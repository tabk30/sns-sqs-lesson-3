import { SQSClient, Message, DeleteMessageCommand } from '@aws-sdk/client-sqs'
import { Injectable } from '@nestjs/common'
import { Consumer } from 'sqs-consumer'
import { MailerService } from '@nestjs-modules/mailer'
import {
  UserMessageEntity,
  UserMessageType,
} from './entities/user-message.entity'
import { fromIni } from '@aws-sdk/credential-providers'

const mesAttToObj = (MessageAttributes: Record<string, any>) => {
  const result: Record<string, any> = {}
  for (const key in MessageAttributes) {
    const value = MessageAttributes[key]
    if (value && value.Type) {
      if (value.Type == 'String') {
        result[key] = value.Value
      } else if (value.Type == 'Number') {
        result[key] = Number(value.Value)
      }
    }
  }
  return result
}

@Injectable()
export class UserConsumer {
  private sqsClient: SQSClient
  constructor(private readonly mailerService: MailerService) {
    this.sqsClient = new SQSClient({
      credentials: fromIni({
        profile: 'default',
      }),
    })
    const app = Consumer.create({
      queueUrl:
        'https://sqs.ap-southeast-1.amazonaws.com/377116985439/lesson-3-send-mail',
      handleMessage: async (message) => {
        // ...
        this.onSqsMessage(message)
      },
      sqs: new SQSClient({
        region: 'ap-southeast-1',
        credentials: {
          accessKeyId: 'AKIAVPTPMRBPVK5VUWBB',
          secretAccessKey: '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',
        },
      }),
    })
    app.on('error', (err) => {
      console.error(err.message)
    })

    app.on('processing_error', (err) => {
      console.error(err.message)
    })

    app.on('timeout_error', (err) => {
      console.error(err.message)
    })

    app.start()
  }

  async onSqsMessage(message: Message) {
    const body = JSON.parse(message.Body)
    const { Message, MessageAttributes } = body
    console.log(
      'onSqsMessage body payload',
      MessageAttributes,
      mesAttToObj(MessageAttributes),
    )
    const payload: UserMessageEntity = new UserMessageEntity({
      message: Message,
      body: mesAttToObj(MessageAttributes),
    })
    try {
      if (payload.message == UserMessageType.USER_REGIST)
        await this.notifyUserRegist({
          email: payload.body.userEmail,
          name: payload.body.userName,
        })
      await this.sqsClient.send(
        new DeleteMessageCommand({
          QueueUrl:
            'https://sqs.ap-southeast-1.amazonaws.com/377116985439/lesson-3-send-mail',
          ReceiptHandle: message.ReceiptHandle,
        }),
      )
    } catch (error) {
      console.error(error)
    }
  }

  async notifyUserRegist({ email, name }: { email: string; name: string }) {
    const res = await this.mailerService.sendMail({
      transporterName: 'ses',
      to: email,
      subject: 'Welcome to Lesson3',
      template: 'user-invited',
      context: {
        webURL: 'https://pionero.io',
      },
    })
    console.log('notifyUserRegist', res)
  }
}

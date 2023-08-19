import { SQSClient, Message } from '@aws-sdk/client-sqs'
import { Injectable } from '@nestjs/common'
import { Consumer } from 'sqs-consumer'

@Injectable()
export class UserConsumer {
  constructor() {
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

  onSqsMessage(message: Message) {
    console.log('onSqsMessage', message)
  }
}

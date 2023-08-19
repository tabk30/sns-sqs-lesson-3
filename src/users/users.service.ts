import { BadRequestException, Injectable } from '@nestjs/common'
import { CreateUserDto } from './dto/create-user.dto'
import { UpdateUserDto } from './dto/update-user.dto'
import { PrismaService } from 'src/db'
import { UserStatus } from '@prisma/client'
import { UserEntity } from './entities/user.entity'
import { PublishCommand, SNS, SNSClient } from '@aws-sdk/client-sns'
import { fromIni } from '@aws-sdk/credential-providers'
import { UserMessageType } from './entities/user-message.entity'

@Injectable()
export class UsersService {
  private _sns: SNSClient
  constructor(private readonly prisma: PrismaService) {
    this._sns = new SNSClient({
      credentials: fromIni({ profile: 'default' }),
    })
  }
  async create(createUserDto: CreateUserDto) {
    const { email } = createUserDto
    const userDB = await this.prisma.user.findUnique({
      where: {
        email: email,
      },
    })
    if (userDB) throw new BadRequestException(`Email ${email} used!`)
    const user = await this.prisma.user.create({
      data: {
        ...createUserDto,
        status: UserStatus.INVITED,
      },
    })
    console.log(
      'send message',
      JSON.stringify({
        type: UserMessageType.USER_REGIST,
        body: user,
      }),
    )
    const res = await this._sns.send(
      new PublishCommand({
        Message: UserMessageType.USER_REGIST,
        MessageAttributes: {
          userId: {
            DataType: 'String',
            StringValue: `${user.id}`,
          },
          userName: {
            DataType: 'String',
            StringValue: user.displayName,
          },
          userEmail: {
            DataType: 'String',
            StringValue: user.email,
          },
        },
        TopicArn: 'arn:aws:sns:ap-southeast-1:377116985439:Lesson-3',
        // MessageDeduplicationId: `${user.id}`,
        // MessageStructure: 'json',
      }),
    )

    console.log('send to SNS', res)

    return new UserEntity(user)
  }

  async login(email: string) {
    let user = await this.prisma.user.findFirstOrThrow({
      where: {
        email: email,
      },
    })
    if (user.status === UserStatus.INVITED) {
      user = await this.prisma.user.update({
        where: {
          id: user.id,
        },
        data: {
          status: UserStatus.ACTIVE,
        },
      })
      // save to back-up DB
      // send notify
    }
    return new UserEntity(user)
  }

  findAll() {
    return `This action returns all users`
  }

  findOne(id: number) {
    return `This action returns a #${id} user`
  }

  update(id: number, updateUserDto: UpdateUserDto) {
    return `This action updates a #${id} user`
  }

  remove(id: number) {
    return `This action removes a #${id} user`
  }
}

import { $Enums, User } from '@prisma/client'

export enum UserMessageType {
  USER_REGIST = 'USER_REGIST',
  USER_JOIN = 'USER_JOIN',
}
export class UserMessageEntity {
  constructor(user: Partial<UserMessageEntity>) {
    Object.assign(this, user)
  }
  body: Record<string, any>
  message: UserMessageType
}

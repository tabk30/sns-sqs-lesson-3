import { $Enums, User } from '@prisma/client'

export class UserEntity implements User {
  constructor(user: Partial<UserEntity>) {
    Object.assign(this, user)
  }
  id: number
  email: string
  displayName: string
  status: $Enums.UserStatus
  createdAt: Date
  updatedAt: Date
  createdBy: number
  updatedBy: number
}

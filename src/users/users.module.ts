import { Module } from '@nestjs/common'
import { UsersService } from './users.service'
import { UsersController } from './users.controller'
import { UserConsumer } from './user.consumer'

@Module({
  controllers: [UsersController],
  providers: [UsersService, UserConsumer],
})
export class UsersModule {}

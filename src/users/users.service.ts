import { Injectable } from '@nestjs/common'
import { CreateUserDto } from './dto/create-user.dto'
import { UpdateUserDto } from './dto/update-user.dto'
import { PrismaService } from 'src/db'
import { UserStatus } from '@prisma/client'
import { UserEntity } from './entities/user.entity'

@Injectable()
export class UsersService {
  constructor(private readonly prisma: PrismaService) {}
  async create(createUserDto: CreateUserDto) {
    const user = await this.prisma.user.create({
      data: {
        ...createUserDto,
        status: UserStatus.INVITED,
      },
    })
    // Send notify to themself
    // Send notify to admin
    // push to front-end
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

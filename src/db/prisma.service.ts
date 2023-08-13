import {
  Inject,
  Injectable,
  Logger,
  OnModuleInit,
  Optional,
} from '@nestjs/common'
import { Prisma, PrismaClient } from '@prisma/client'

import { PrismaServiceOptions } from './interfaces'
import { PRISMA_SERVICE_OPTIONS } from './prisma.constants'

@Injectable()
export class PrismaService
  extends PrismaClient<Prisma.PrismaClientOptions, 'query' | 'error'>
  implements OnModuleInit
{
  private readonly logger = new Logger(PrismaService.name)

  constructor(
    @Optional()
    @Inject(PRISMA_SERVICE_OPTIONS)
    private readonly prismaServiceOptions: PrismaServiceOptions = {},
  ) {
    super(prismaServiceOptions.prismaOptions)

    if (this.prismaServiceOptions.middlewares) {
      this.prismaServiceOptions.middlewares.forEach((middleware) =>
        this.$use(middleware),
      )
    }

    this.$on('query', (e) => {
      this.logger.log('Query: ' + e.query)
      this.logger.log('Params: ' + e.params)
      this.logger.log('Duration: ' + e.duration + 'ms')
    })
  }

  async onModuleInit() {
    if (this.prismaServiceOptions.explicitConnect) {
      await this.$connect()
    }
  }
}

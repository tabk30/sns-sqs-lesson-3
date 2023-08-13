import { Module } from '@nestjs/common'
import { AppController } from './app.controller'
import { AppService } from './app.service'
import { ConfigModule } from '@nestjs/config'
import { PrismaModule } from './db'
import { prismaLoggingMiddleware } from './db/prisma.logging.middleware'
import { UsersModule } from './users/users.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      expandVariables: true,
      validationOptions: {
        allowUnknow: false,
        abortEarly: true,
      },
      // validationSchema: configSchema,
    }),
    PrismaModule.forRoot({
      isGlobal: true,
      prismaServiceOptions: {
        middlewares: [prismaLoggingMiddleware()],
        prismaOptions: {
          // log: ['info', 'error', 'warn', 'query'],
          log: ['error'],
        },
        explicitConnect: true,
      },
    }),
    UsersModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}

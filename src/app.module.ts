import { Module } from '@nestjs/common'
import { AppController } from './app.controller'
import { AppService } from './app.service'
import { ConfigModule, ConfigService } from '@nestjs/config'
import { PrismaModule } from './db'
import { prismaLoggingMiddleware } from './db/prisma.logging.middleware'
import { UsersModule } from './users/users.module'
import { MailerModule } from '@nestjs-modules/mailer'
import { HandlebarsAdapter } from '@nestjs-modules/mailer/dist/adapters/handlebars.adapter'
import path from 'path'

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
    MailerModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: async (configService: ConfigService) => ({
        transports: {
          ses: {
            host: 'arn:aws:ses:ap-southeast-1:377116985439:identity/tabk301991@gmail.com',
            port: 587,
            auth: {
              user: 'AKIAVPTPMRBPXPUBOTF5',
              pass: 'BD3ZiN6lHREhjghNw5mUBcamyO8gLAYVCKkMEzocZYDn',
            },
          },
          // resend: {
          //   host: 'smtp.resend.com',
          //   port: 587,
          //   auth: {
          //     user: 'resend',
          //     pass: configService.get<string>('RESEND_KEY'),
          //   },
          // },
        },
        defaults: {
          from: configService.get<string>('MAILER_DEFAULT_FROM'),
        },
        template: {
          dir: path.join(process.cwd(), 'templates'),
          adapter: new HandlebarsAdapter(),
          options: {
            strict: true,
          },
        },
      }),
      inject: [ConfigService],
    }),
    UsersModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}

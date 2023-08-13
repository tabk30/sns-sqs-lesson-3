/* eslint-disable no-console */
import { PrismaClient, UserStatus } from '@prisma/client'

const prisma = new PrismaClient()

// async function productionData() {}

async function developmentData() {
  await prisma.user.create({
    data: {
      status: UserStatus.ACTIVE,
      displayName: 'Do',
      email: 'hai.do@pionero.io',
    },
  })
}

async function main() {
  // if (process.env.NODE_ENV === 'production') {
  //   return productionData()
  // }
  return developmentData()
}

main()
  .catch((e) => {
    console.error(e)
    process.exit(1)
  })
  .finally(async () => {
    await prisma.$disconnect()
  })

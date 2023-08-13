/*
  Warnings:

  - You are about to drop the `t_ history` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
DROP TABLE `t_ history`;

-- CreateTable
CREATE TABLE `t_history` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `table` VARCHAR(255) NOT NULL,
    `metadata` JSON NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `created_by` INTEGER NULL,

    UNIQUE INDEX `t_history_table_key`(`table`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `d_notifications` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `source` VARCHAR(255) NOT NULL,
    `action` VARCHAR(255) NULL,
    `body` JSON NOT NULL,
    `userId` INTEGER NOT NULL,
    `readed` BOOLEAN NOT NULL DEFAULT false,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `created_by` INTEGER NULL DEFAULT 0,
    `updated_by` INTEGER NULL DEFAULT 0,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

/*
  Warnings:

  - Added the required column `userId` to the `m_users_backup` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `m_users_backup` ADD COLUMN `userId` INTEGER NOT NULL;

-- AlterTable
ALTER TABLE `m_users` ADD COLUMN `user_type` ENUM('FULLTIME', 'PARTTIME', 'INTERN', 'PARTNER') NULL;
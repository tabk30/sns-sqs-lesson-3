/*
  Warnings:

  - You are about to drop the column `avatar` on the `m_users` table. All the data in the column will be lost.
  - You are about to drop the column `effort` on the `m_users` table. All the data in the column will be lost.
  - You are about to drop the column `first_name` on the `m_users` table. All the data in the column will be lost.
  - You are about to drop the column `last_name` on the `m_users` table. All the data in the column will be lost.
  - You are about to drop the column `metadata` on the `m_users` table. All the data in the column will be lost.
  - You are about to drop the column `middle_name` on the `m_users` table. All the data in the column will be lost.
  - You are about to drop the column `role` on the `m_users` table. All the data in the column will be lost.
  - You are about to drop the column `user_type` on the `m_users` table. All the data in the column will be lost.
  - You are about to drop the `d_invoices` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `d_leads` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `d_notifications` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `d_project_members` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `d_projects` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `d_refresh_tokens` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `m_customers` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `m_user_profiles` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `t_history` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `d_invoices` DROP FOREIGN KEY `d_invoices_customer_id_fkey`;

-- DropForeignKey
ALTER TABLE `d_invoices` DROP FOREIGN KEY `d_invoices_in_charge_user_id_fkey`;

-- DropForeignKey
ALTER TABLE `d_invoices` DROP FOREIGN KEY `d_invoices_lead_id_fkey`;

-- DropForeignKey
ALTER TABLE `d_invoices` DROP FOREIGN KEY `d_invoices_project_id_fkey`;

-- DropForeignKey
ALTER TABLE `d_leads` DROP FOREIGN KEY `d_leads_customer_id_fkey`;

-- DropForeignKey
ALTER TABLE `d_leads` DROP FOREIGN KEY `d_leads_in_charge_user_id_fkey`;

-- DropForeignKey
ALTER TABLE `d_project_members` DROP FOREIGN KEY `d_project_members_project_id_fkey`;

-- DropForeignKey
ALTER TABLE `d_project_members` DROP FOREIGN KEY `d_project_members_user_id_fkey`;

-- DropForeignKey
ALTER TABLE `d_projects` DROP FOREIGN KEY `d_projects_customer_id_fkey`;

-- DropForeignKey
ALTER TABLE `d_projects` DROP FOREIGN KEY `d_projects_lead_id_fkey`;

-- DropForeignKey
ALTER TABLE `m_customers` DROP FOREIGN KEY `m_customers_in_charge_user_id_fkey`;

-- DropForeignKey
ALTER TABLE `m_user_profiles` DROP FOREIGN KEY `m_user_profiles_id_fkey`;

-- AlterTable
ALTER TABLE `m_users` DROP COLUMN `avatar`,
    DROP COLUMN `effort`,
    DROP COLUMN `first_name`,
    DROP COLUMN `last_name`,
    DROP COLUMN `metadata`,
    DROP COLUMN `middle_name`,
    DROP COLUMN `role`,
    DROP COLUMN `user_type`;

-- DropTable
DROP TABLE `d_invoices`;

-- DropTable
DROP TABLE `d_leads`;

-- DropTable
DROP TABLE `d_notifications`;

-- DropTable
DROP TABLE `d_project_members`;

-- DropTable
DROP TABLE `d_projects`;

-- DropTable
DROP TABLE `d_refresh_tokens`;

-- DropTable
DROP TABLE `m_customers`;

-- DropTable
DROP TABLE `m_user_profiles`;

-- DropTable
DROP TABLE `t_history`;

-- CreateTable
CREATE TABLE `t_ history` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `table` VARCHAR(255) NOT NULL,
    `metadata` JSON NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `created_by` INTEGER NULL,

    UNIQUE INDEX `t_ history_table_key`(`table`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `m_users` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `email` VARCHAR(255) NOT NULL,
    `display_name` VARCHAR(255) NULL,
    `first_name` VARCHAR(255) NULL,
    `middle_name` VARCHAR(255) NULL,
    `last_name` VARCHAR(255) NULL,
    `avatar` TEXT NULL,
    `role` ENUM('ADMIN', 'SALE', 'HR_MANAGER', 'HR_STAFF', 'ACCOUNTANT', 'FULLTIME', 'PARTTIME') NOT NULL,
    `status` ENUM('INVITED', 'ACTIVE', 'INACTIVE') NOT NULL,
    `metadata` JSON NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `created_by` INTEGER NULL,
    `updated_by` INTEGER NULL,

    UNIQUE INDEX `m_users_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `m_user_profiles` (
    `id` INTEGER NOT NULL,
    `user_seq` INTEGER NOT NULL,
    `user_type` ENUM('FULLTIME', 'PARTTIME', 'INTERN', 'PARTNER') NOT NULL,
    `birthday` DATETIME(3) NOT NULL,
    `gender` ENUM('MALE', 'FEMALE', 'OTHER') NOT NULL,
    `tel` VARCHAR(12) NOT NULL,
    `address` TEXT NOT NULL,
    `metadata` JSON NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `created_by` INTEGER NULL,
    `updated_by` INTEGER NULL,

    UNIQUE INDEX `m_user_profiles_id_key`(`id`),
    UNIQUE INDEX `m_user_profiles_user_seq_user_type_key`(`user_seq`, `user_type`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `d_refresh_tokens` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `token` VARCHAR(191) NOT NULL,
    `user_id` INTEGER NOT NULL,
    `expired_at` DATETIME(3) NOT NULL,
    `user_agent` VARCHAR(191) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `d_refresh_tokens_token_key`(`token`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `m_customers` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `desc` TEXT NULL,
    `rank` INTEGER NOT NULL DEFAULT 0,
    `in_charge_user_id` INTEGER NULL,
    `contact_job_title` VARCHAR(255) NULL,
    `contact_name` VARCHAR(255) NULL,
    `contact_email` VARCHAR(255) NULL,
    `url` TEXT NULL,
    `tel` VARCHAR(12) NULL,
    `fax` VARCHAR(12) NULL,
    `post_code` VARCHAR(10) NULL,
    `address` TEXT NULL,
    `accounting_name` VARCHAR(255) NULL,
    `accounting_email` VARCHAR(255) NULL,
    `remarks` TEXT NULL,
    `metadata` JSON NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `created_by` INTEGER NULL,
    `updated_by` INTEGER NULL,

    UNIQUE INDEX `m_customers_name_key`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `d_leads` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `rank` INTEGER NOT NULL DEFAULT 0,
    `source` VARCHAR(255) NULL,
    `customer_id` INTEGER NOT NULL,
    `link` TEXT NULL,
    `name` VARCHAR(1023) NOT NULL,
    `desc` TEXT NULL,
    `expected_start_date` DATETIME(3) NULL,
    `expected_end_date` DATETIME(3) NULL,
    `deal_size` INTEGER NOT NULL DEFAULT 0,
    `contact_job_title` VARCHAR(255) NULL,
    `contact_name` VARCHAR(255) NOT NULL,
    `contact_email` VARCHAR(255) NULL,
    `status` ENUM('APPO', 'MTG', 'EST', 'PREORDER', 'ORDER', 'LOST', 'BID') NOT NULL,
    `confidence` INTEGER NOT NULL DEFAULT 0,
    `in_charge_user_id` INTEGER NOT NULL,
    `supporters` TEXT NULL,
    `docs_link` TEXT NULL,
    `remarks` TEXT NULL,
    `metadata` JSON NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `created_by` INTEGER NULL,
    `updated_by` INTEGER NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `d_projects` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `parentId` INTEGER NULL,
    `code` VARCHAR(10) NOT NULL,
    `name` VARCHAR(1023) NOT NULL,
    `desc` TEXT NULL,
    `lead_id` INTEGER NULL,
    `customer_id` INTEGER NULL,
    `type` ENUM('PRJ', 'LAB') NOT NULL,
    `order_date` DATETIME(3) NULL,
    `expected_start_date` DATETIME(3) NULL,
    `expected_end_date` DATETIME(3) NOT NULL,
    `kickoff_date` DATETIME(3) NOT NULL,
    `internal_deadline` DATETIME(3) NOT NULL,
    `end_date` DATETIME(3) NOT NULL,
    `status` ENUM('OPEN', 'NEW', 'ONGOING', 'UAT', 'CLOSED', 'MAINTAIN', 'FAILED', 'DELAY', 'PENDING') NOT NULL,
    `progress` ENUM('ON_TARGET', 'AT_RISK', 'OFF_TRACK') NOT NULL,
    `estimated_cost` INTEGER NOT NULL DEFAULT 0,
    `current_cost` INTEGER NOT NULL DEFAULT 0,
    `cr_cost` INTEGER NOT NULL DEFAULT 0,
    `estimated_mm` DOUBLE NOT NULL DEFAULT 0,
    `current_mm` DOUBLE NOT NULL DEFAULT 0,
    `cr_mm` DOUBLE NOT NULL DEFAULT 0,
    `contact_job_title` VARCHAR(255) NULL,
    `contact_name` VARCHAR(255) NULL,
    `contact_email` VARCHAR(255) NULL,
    `docs_link` TEXT NULL,
    `remarks` TEXT NULL,
    `metadata` JSON NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `created_by` INTEGER NULL,
    `updated_by` INTEGER NULL,

    UNIQUE INDEX `d_projects_code_key`(`code`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `d_project_members` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `project_id` INTEGER NOT NULL,
    `user_id` INTEGER NOT NULL,
    `position` ENUM('INTERN', 'DEV', 'TESTER', 'TECHLEAD', 'PM', 'ADVISOR', 'LEADER', 'SALE') NOT NULL,
    `effort_rate` INTEGER NOT NULL DEFAULT 0,
    `expected_effort` DOUBLE NOT NULL DEFAULT 0,
    `real_effort` DOUBLE NOT NULL DEFAULT 0,
    `cost` INTEGER NOT NULL DEFAULT 0,
    `status` ENUM('ACTIVE', 'EXITED', 'WAIT') NOT NULL,
    `contribute_rate` INTEGER NOT NULL DEFAULT 0,
    `remarks` TEXT NULL,
    `metadata` JSON NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `created_by` INTEGER NULL,
    `updated_by` INTEGER NULL,

    UNIQUE INDEX `d_project_members_project_id_user_id_key`(`project_id`, `user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `d_invoices` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `code` VARCHAR(20) NOT NULL,
    `seq` INTEGER NOT NULL DEFAULT 0,
    `lead_id` INTEGER NULL,
    `customer_id` INTEGER NOT NULL,
    `project_id` INTEGER NULL,
    `name` VARCHAR(1023) NOT NULL,
    `desc` TEXT NULL,
    `amount` INTEGER NOT NULL DEFAULT 0,
    `tax` INTEGER NOT NULL DEFAULT 0,
    `total_amount` INTEGER NOT NULL DEFAULT 0,
    `uploaded_pdf` TEXT NULL,
    `generated_pdf` TEXT NULL,
    `status` ENUM('DRAFT', 'APPROVED', 'REJECTED', 'SENT', 'CLOSED') NOT NULL,
    `in_charge_user_id` INTEGER NULL,
    `scheduled_send_at` DATETIME(3) NULL,
    `payment_deadline` DATETIME(3) NULL,
    `sent_date` DATETIME(3) NULL,
    `paid_date` DATETIME(3) NULL,
    `remarks` TEXT NULL,
    `metadata` JSON NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `created_by` INTEGER NULL,
    `updated_by` INTEGER NULL,

    UNIQUE INDEX `d_invoices_code_key`(`code`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `m_user_profiles` ADD CONSTRAINT `m_user_profiles_id_fkey` FOREIGN KEY (`id`) REFERENCES `m_users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `m_customers` ADD CONSTRAINT `m_customers_in_charge_user_id_fkey` FOREIGN KEY (`in_charge_user_id`) REFERENCES `m_users`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `d_leads` ADD CONSTRAINT `d_leads_in_charge_user_id_fkey` FOREIGN KEY (`in_charge_user_id`) REFERENCES `m_users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `d_leads` ADD CONSTRAINT `d_leads_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `m_customers`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `d_projects` ADD CONSTRAINT `d_projects_lead_id_fkey` FOREIGN KEY (`lead_id`) REFERENCES `d_leads`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `d_projects` ADD CONSTRAINT `d_projects_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `m_customers`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `d_project_members` ADD CONSTRAINT `d_project_members_project_id_fkey` FOREIGN KEY (`project_id`) REFERENCES `d_projects`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `d_project_members` ADD CONSTRAINT `d_project_members_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `m_users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `d_invoices` ADD CONSTRAINT `d_invoices_lead_id_fkey` FOREIGN KEY (`lead_id`) REFERENCES `d_leads`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `d_invoices` ADD CONSTRAINT `d_invoices_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `m_customers`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `d_invoices` ADD CONSTRAINT `d_invoices_project_id_fkey` FOREIGN KEY (`project_id`) REFERENCES `d_projects`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `d_invoices` ADD CONSTRAINT `d_invoices_in_charge_user_id_fkey` FOREIGN KEY (`in_charge_user_id`) REFERENCES `m_users`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- CreateTable
CREATE TABLE `inventory` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `category` VARCHAR(100) NOT NULL,
    `description` VARCHAR(500) NULL,
    `quantity` INTEGER NOT NULL DEFAULT 0,
    `unit` VARCHAR(50) NOT NULL,
    `pricePerUnit` DOUBLE NULL,
    `status` VARCHAR(50) NULL,
    `dateReceived` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `dateUpdated` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `expiryDate` DATETIME(3) NULL,
    `image` VARCHAR(255) NULL,
    `initialQuantity` INTEGER NULL DEFAULT 0,
    `supplierId` INTEGER NULL,

    UNIQUE INDEX `inventory_name_key`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

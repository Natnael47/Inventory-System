/*
  Warnings:

  - The primary key for the `inventory` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `category` on the `inventory` table. All the data in the column will be lost.
  - You are about to drop the column `dateReceived` on the `inventory` table. All the data in the column will be lost.
  - You are about to drop the column `dateUpdated` on the `inventory` table. All the data in the column will be lost.
  - You are about to drop the column `description` on the `inventory` table. All the data in the column will be lost.
  - You are about to drop the column `expiryDate` on the `inventory` table. All the data in the column will be lost.
  - You are about to drop the column `id` on the `inventory` table. All the data in the column will be lost.
  - You are about to drop the column `image` on the `inventory` table. All the data in the column will be lost.
  - You are about to drop the column `initialQuantity` on the `inventory` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `inventory` table. All the data in the column will be lost.
  - You are about to drop the column `pricePerUnit` on the `inventory` table. All the data in the column will be lost.
  - You are about to drop the column `quantity` on the `inventory` table. All the data in the column will be lost.
  - You are about to drop the column `status` on the `inventory` table. All the data in the column will be lost.
  - You are about to drop the column `supplierId` on the `inventory` table. All the data in the column will be lost.
  - You are about to drop the column `unit` on the `inventory` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[Product_Name]` on the table `inventory` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `Inventory_Id` to the `inventory` table without a default value. This is not possible if the table is not empty.
  - Added the required column `Product_Category` to the `inventory` table without a default value. This is not possible if the table is not empty.
  - Added the required column `Product_Name` to the `inventory` table without a default value. This is not possible if the table is not empty.
  - Added the required column `Unit_Of_Measurement` to the `inventory` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX `inventory_name_key` ON `inventory`;

-- AlterTable
ALTER TABLE `inventory` DROP PRIMARY KEY,
    DROP COLUMN `category`,
    DROP COLUMN `dateReceived`,
    DROP COLUMN `dateUpdated`,
    DROP COLUMN `description`,
    DROP COLUMN `expiryDate`,
    DROP COLUMN `id`,
    DROP COLUMN `image`,
    DROP COLUMN `initialQuantity`,
    DROP COLUMN `name`,
    DROP COLUMN `pricePerUnit`,
    DROP COLUMN `quantity`,
    DROP COLUMN `status`,
    DROP COLUMN `supplierId`,
    DROP COLUMN `unit`,
    ADD COLUMN `Expiry_Date` DATETIME(3) NULL,
    ADD COLUMN `Initial_Stock_Quantity` INTEGER NULL DEFAULT 0,
    ADD COLUMN `Inventory_Id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD COLUMN `Is_Discontinued` BOOLEAN NOT NULL DEFAULT false,
    ADD COLUMN `Product_Category` VARCHAR(100) NOT NULL,
    ADD COLUMN `Product_Description` VARCHAR(500) NULL,
    ADD COLUMN `Product_Name` VARCHAR(255) NOT NULL,
    ADD COLUMN `Reorder_Threshold` INTEGER NULL,
    ADD COLUMN `Stock_Quantity` INTEGER NOT NULL DEFAULT 0,
    ADD COLUMN `Stock_Status` VARCHAR(50) NULL,
    ADD COLUMN `Storage_Location` VARCHAR(255) NULL,
    ADD COLUMN `Supplier_Id` INTEGER NULL,
    ADD COLUMN `Total_Value` DOUBLE NULL,
    ADD COLUMN `Unit_Of_Measurement` VARCHAR(50) NOT NULL,
    ADD COLUMN `Unit_Price` DOUBLE NULL,
    ADD COLUMN `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `updatedAt` DATETIME(3) NULL,
    ADD PRIMARY KEY (`Inventory_Id`);

-- CreateTable
CREATE TABLE `withdrawal_log` (
    `WithdrawalLog_Id` INTEGER NOT NULL AUTO_INCREMENT,
    `Inventory_Id` INTEGER NOT NULL,
    `Employee_Id` INTEGER NULL,
    `Withdrawal_Reason` VARCHAR(191) NULL,
    `Quantity_Withdrawn` INTEGER NOT NULL,
    `Date_Withdrawn` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL,

    PRIMARY KEY (`WithdrawalLog_Id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inventory_purchase` (
    `Purchase_Id` INTEGER NOT NULL AUTO_INCREMENT,
    `Inventory_Id` INTEGER NOT NULL,
    `Employee_Id` INTEGER NULL,
    `Supplier_Id` INTEGER NULL,
    `Purchase_Date` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `Quantity_Purchased` INTEGER NOT NULL,
    `Total_Cost` DOUBLE NULL,
    `Unit_Price` DOUBLE NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL,

    PRIMARY KEY (`Purchase_Id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `stock_batch` (
    `StockBatch_Id` INTEGER NOT NULL AUTO_INCREMENT,
    `Batch_Number` VARCHAR(50) NOT NULL,
    `Inventory_Id` INTEGER NOT NULL,
    `Supplier_Id` INTEGER NULL,
    `Purchase_Date` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `Quantity_Purchased` INTEGER NOT NULL,
    `Unit_Price` DOUBLE NOT NULL,
    `Expiry_Date` DATETIME(3) NULL,
    `Remaining_Quantity` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL,

    UNIQUE INDEX `stock_batch_Batch_Number_key`(`Batch_Number`),
    PRIMARY KEY (`StockBatch_Id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `supplier` (
    `Supplier_Id` INTEGER NOT NULL AUTO_INCREMENT,
    `Supplier_Name` VARCHAR(255) NOT NULL,
    `Contact_Name` VARCHAR(255) NULL,
    `Contact_Phone_Number` VARCHAR(15) NULL,
    `Contact_Email` VARCHAR(255) NULL,
    `Notes` TEXT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL,

    UNIQUE INDEX `supplier_Contact_Email_key`(`Contact_Email`),
    PRIMARY KEY (`Supplier_Id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `employee` (
    `Employee_Id` INTEGER NOT NULL AUTO_INCREMENT,
    `First_Name` VARCHAR(255) NOT NULL,
    `Last_Name` VARCHAR(255) NOT NULL,
    `Gender` VARCHAR(50) NOT NULL,
    `Email` VARCHAR(255) NOT NULL,
    `Password` VARCHAR(255) NOT NULL,
    `Profile_Image` VARCHAR(255) NULL,
    `Phone_Number` VARCHAR(20) NOT NULL,
    `Job_Position` VARCHAR(100) NOT NULL,
    `Work_Shift` VARCHAR(100) NOT NULL,
    `Education_Details` VARCHAR(255) NOT NULL,
    `Work_Experience` VARCHAR(255) NOT NULL,
    `Monthly_Salary` FLOAT NOT NULL,
    `Address` JSON NOT NULL,
    `About_Employee` TEXT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL,

    UNIQUE INDEX `employee_Email_key`(`Email`),
    PRIMARY KEY (`Employee_Id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `work_log` (
    `WorkLog_Id` INTEGER NOT NULL AUTO_INCREMENT,
    `Employee_Id` INTEGER NOT NULL,
    `Login_Time` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `Logout_Time` DATETIME(3) NULL,

    PRIMARY KEY (`WorkLog_Id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE UNIQUE INDEX `inventory_Product_Name_key` ON `inventory`(`Product_Name`);

-- AddForeignKey
ALTER TABLE `inventory` ADD CONSTRAINT `inventory_Supplier_Id_fkey` FOREIGN KEY (`Supplier_Id`) REFERENCES `supplier`(`Supplier_Id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `withdrawal_log` ADD CONSTRAINT `withdrawal_log_Inventory_Id_fkey` FOREIGN KEY (`Inventory_Id`) REFERENCES `inventory`(`Inventory_Id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `withdrawal_log` ADD CONSTRAINT `withdrawal_log_Employee_Id_fkey` FOREIGN KEY (`Employee_Id`) REFERENCES `employee`(`Employee_Id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `inventory_purchase` ADD CONSTRAINT `inventory_purchase_Inventory_Id_fkey` FOREIGN KEY (`Inventory_Id`) REFERENCES `inventory`(`Inventory_Id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `inventory_purchase` ADD CONSTRAINT `inventory_purchase_Supplier_Id_fkey` FOREIGN KEY (`Supplier_Id`) REFERENCES `supplier`(`Supplier_Id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `inventory_purchase` ADD CONSTRAINT `inventory_purchase_Employee_Id_fkey` FOREIGN KEY (`Employee_Id`) REFERENCES `employee`(`Employee_Id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `stock_batch` ADD CONSTRAINT `stock_batch_Inventory_Id_fkey` FOREIGN KEY (`Inventory_Id`) REFERENCES `inventory`(`Inventory_Id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `stock_batch` ADD CONSTRAINT `stock_batch_Supplier_Id_fkey` FOREIGN KEY (`Supplier_Id`) REFERENCES `supplier`(`Supplier_Id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `work_log` ADD CONSTRAINT `work_log_Employee_Id_fkey` FOREIGN KEY (`Employee_Id`) REFERENCES `employee`(`Employee_Id`) ON DELETE RESTRICT ON UPDATE CASCADE;

/*
  Warnings:

  - You are about to drop the column `date` on the `worker_schedule` table. All the data in the column will be lost.

*/
-- DropIndex
DROP INDEX "appointment_client_phone_key";

-- AlterTable
ALTER TABLE "worker_schedule" DROP COLUMN "date";

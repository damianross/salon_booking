/*
  Warnings:

  - You are about to drop the column `date` on the `appointment` table. All the data in the column will be lost.
  - Added the required column `status` to the `appointment` table without a default value. This is not possible if the table is not empty.
  - Added the required column `time` to the `appointment` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "Status" AS ENUM ('PENDING', 'CONFIRMED', 'COMPLETED', 'CANCELED');

-- AlterTable
ALTER TABLE "appointment" DROP COLUMN "date",
ADD COLUMN     "status" "Status" NOT NULL,
ADD COLUMN     "time" TIMESTAMP(3) NOT NULL;

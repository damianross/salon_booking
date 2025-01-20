/*
  Warnings:

  - You are about to drop the `Appointment` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Client` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Worker` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `WorkerSchedule` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Appointment" DROP CONSTRAINT "Appointment_clientId_fkey";

-- DropForeignKey
ALTER TABLE "Appointment" DROP CONSTRAINT "Appointment_workerId_fkey";

-- DropForeignKey
ALTER TABLE "WorkerSchedule" DROP CONSTRAINT "WorkerSchedule_workerId_fkey";

-- DropTable
DROP TABLE "Appointment";

-- DropTable
DROP TABLE "Client";

-- DropTable
DROP TABLE "Worker";

-- DropTable
DROP TABLE "WorkerSchedule";

-- CreateTable
CREATE TABLE "worker" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "email" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "worker_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "appointment" (
    "id" SERIAL NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "client_phone" TEXT NOT NULL,
    "client_name" TEXT NOT NULL,
    "worker_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "appointment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "worker_schedule" (
    "id" SERIAL NOT NULL,
    "worker_id" INTEGER NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "start_time" TIMESTAMP(3) NOT NULL,
    "end_time" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "worker_schedule_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "email_list" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "email_list_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "worker_phone_key" ON "worker"("phone");

-- CreateIndex
CREATE UNIQUE INDEX "worker_email_key" ON "worker"("email");

-- CreateIndex
CREATE UNIQUE INDEX "appointment_client_phone_key" ON "appointment"("client_phone");

-- CreateIndex
CREATE UNIQUE INDEX "email_list_email_key" ON "email_list"("email");

-- AddForeignKey
ALTER TABLE "appointment" ADD CONSTRAINT "appointment_worker_id_fkey" FOREIGN KEY ("worker_id") REFERENCES "worker"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "worker_schedule" ADD CONSTRAINT "worker_schedule_worker_id_fkey" FOREIGN KEY ("worker_id") REFERENCES "worker"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

/*
  Warnings:

  - Changed the type of `amt` on the `Donation` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- AlterTable
ALTER TABLE "Donation" DROP COLUMN "amt",
ADD COLUMN     "amt" DOUBLE PRECISION NOT NULL;

-- DropForeignKey
ALTER TABLE "Donation" DROP CONSTRAINT "Donation_googleId_fkey";

-- AddForeignKey
ALTER TABLE "Donation" ADD CONSTRAINT "Donation_googleId_fkey" FOREIGN KEY ("googleId") REFERENCES "User"("googleId") ON DELETE CASCADE ON UPDATE CASCADE;

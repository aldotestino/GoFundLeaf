-- CreateTable
CREATE TABLE "User" (
    "googleId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "surname" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "photoUrl" TEXT NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("googleId")
);

-- CreateTable
CREATE TABLE "Donation" (
    "googleId" TEXT NOT NULL,
    "amt" TEXT NOT NULL,
    "dateTime" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Donation_pkey" PRIMARY KEY ("googleId","dateTime")
);

-- AddForeignKey
ALTER TABLE "Donation" ADD CONSTRAINT "Donation_googleId_fkey" FOREIGN KEY ("googleId") REFERENCES "User"("googleId") ON DELETE RESTRICT ON UPDATE CASCADE;

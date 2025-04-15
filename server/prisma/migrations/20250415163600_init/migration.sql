-- CreateEnum
CREATE TYPE "Role" AS ENUM ('INSTRUCTOR', 'STUDENT');

-- CreateEnum
CREATE TYPE "CourseLevel" AS ENUM ('BEGINNER', 'MEDIUM', 'ADVANCE');

-- CreateEnum
CREATE TYPE "PaymentStatus" AS ENUM ('PENDING', 'COMPLETED', 'FAILED');

-- CreateTable
CREATE TABLE "User" (
    "uuid" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'STUDENT',

    CONSTRAINT "User_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "Course" (
    "courseId" TEXT NOT NULL,
    "imgLink" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "subtitle" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "category" TEXT NOT NULL,
    "courseLevel" "CourseLevel" NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "isFeatured" BOOLEAN NOT NULL DEFAULT false,
    "creatorId" TEXT NOT NULL,

    CONSTRAINT "Course_pkey" PRIMARY KEY ("courseId")
);

-- CreateTable
CREATE TABLE "Lecture" (
    "lectureID" TEXT NOT NULL,
    "lectureTitle" TEXT NOT NULL,
    "lectureDescription" TEXT NOT NULL,
    "videoURL" TEXT NOT NULL,
    "courseId" TEXT NOT NULL,

    CONSTRAINT "Lecture_pkey" PRIMARY KEY ("lectureID")
);

-- CreateTable
CREATE TABLE "Payment" (
    "id" TEXT NOT NULL,
    "courseId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "status" "PaymentStatus" NOT NULL,
    "paymentId" TEXT NOT NULL,

    CONSTRAINT "Payment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_EnrolledCourses" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,

    CONSTRAINT "_EnrolledCourses_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Payment_paymentId_key" ON "Payment"("paymentId");

-- CreateIndex
CREATE INDEX "_EnrolledCourses_B_index" ON "_EnrolledCourses"("B");

-- AddForeignKey
ALTER TABLE "Course" ADD CONSTRAINT "Course_creatorId_fkey" FOREIGN KEY ("creatorId") REFERENCES "User"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Lecture" ADD CONSTRAINT "Lecture_courseId_fkey" FOREIGN KEY ("courseId") REFERENCES "Course"("courseId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Payment" ADD CONSTRAINT "Payment_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Payment" ADD CONSTRAINT "Payment_courseId_fkey" FOREIGN KEY ("courseId") REFERENCES "Course"("courseId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_EnrolledCourses" ADD CONSTRAINT "_EnrolledCourses_A_fkey" FOREIGN KEY ("A") REFERENCES "Course"("courseId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_EnrolledCourses" ADD CONSTRAINT "_EnrolledCourses_B_fkey" FOREIGN KEY ("B") REFERENCES "User"("uuid") ON DELETE CASCADE ON UPDATE CASCADE;

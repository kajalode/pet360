-- CreateEnum
CREATE TYPE "Species" AS ENUM ('DOG', 'CAT', 'BIRD', 'RODENT', 'REPTILE', 'FISH', 'OTHER');

-- CreateEnum
CREATE TYPE "PetSize" AS ENUM ('MINI', 'SMALL', 'MEDIUM', 'LARGE', 'GIANT');

-- CreateEnum
CREATE TYPE "PetGender" AS ENUM ('MALE', 'FEMALE', 'UNKNOWN');

-- CreateEnum
CREATE TYPE "AdoptionStatus" AS ENUM ('AVAILABLE', 'IN_PROCESS', 'ADOPTED', 'RETURNED', 'UNAVAILABLE');

-- CreateEnum
CREATE TYPE "BoardingStatus" AS ENUM ('RESERVED', 'CHECKED_IN', 'CHECKED_OUT', 'CANCELLED', 'NO_SHOW');

-- CreateEnum
CREATE TYPE "AppointmentStatus" AS ENUM ('SCHEDULED', 'CONFIRMED', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED', 'NO_SHOW');

-- CreateEnum
CREATE TYPE "AppointmentType" AS ENUM ('CONSULTATION', 'VACCINE', 'SURGERY', 'EXAM', 'GROOMING', 'RETURN', 'EMERGENCY', 'TRAINING');

-- CreateEnum
CREATE TYPE "PaymentMethod" AS ENUM ('CASH', 'PIX', 'CREDIT_CARD', 'DEBIT_CARD', 'TRANSFER', 'INSTALLMENT');

-- CreateEnum
CREATE TYPE "PaymentStatus" AS ENUM ('PENDING', 'PAID', 'PARTIAL', 'REFUNDED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "VaccineType" AS ENUM ('V8', 'V10', 'RABIES', 'GIARDIA', 'FLU', 'LEISHMANIASIS', 'FELINE_TRIPLE', 'FELINE_QUADRUPLE', 'FELINE_LEUKEMIA', 'OTHER');

-- CreateEnum
CREATE TYPE "StockMovementType" AS ENUM ('PURCHASE', 'SALE', 'SERVICE_USE', 'ADJUSTMENT', 'RETURN', 'LOSS', 'EXPIRED');

-- CreateEnum
CREATE TYPE "RoomType" AS ENUM ('INDIVIDUAL', 'SHARED', 'SUITE', 'ICU');

-- CreateEnum
CREATE TYPE "UserRole" AS ENUM ('OWNER', 'ADMIN', 'VET', 'GROOMER', 'ATTENDANT', 'TRAINER');

-- CreateEnum
CREATE TYPE "PetSitterStatus" AS ENUM ('PENDING_APPROVAL', 'APPROVED', 'REJECTED', 'SUSPENDED');

-- CreateEnum
CREATE TYPE "BookingStatus" AS ENUM ('PENDING', 'CONFIRMED', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED', 'DISPUTED');

-- CreateEnum
CREATE TYPE "ListingStatus" AS ENUM ('DRAFT', 'PENDING_REVIEW', 'ACTIVE', 'PAUSED', 'SOLD', 'EXPIRED', 'REJECTED');

-- CreateTable
CREATE TABLE "businesses" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "cnpj" TEXT,
    "phone" TEXT NOT NULL,
    "email" TEXT,
    "businessTypes" TEXT[],
    "address" TEXT,
    "city" TEXT,
    "state" TEXT,
    "zipCode" TEXT,
    "logoUrl" TEXT,
    "whatsappInstanceId" TEXT,
    "whatsappConnected" BOOLEAN NOT NULL DEFAULT false,
    "settings" JSONB NOT NULL DEFAULT '{}',
    "openingHours" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "businesses_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users" (
    "id" TEXT NOT NULL,
    "businessId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "role" "UserRole" NOT NULL DEFAULT 'ATTENDANT',
    "crmv" TEXT,
    "specialties" TEXT[],
    "color" TEXT,
    "passwordHash" TEXT,
    "otpCode" TEXT,
    "otpExpiresAt" TIMESTAMP(3),
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "commissionRate" DECIMAL(5,2),
    "avatarUrl" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tutors" (
    "id" TEXT NOT NULL,
    "businessId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "cpf" TEXT,
    "email" TEXT,
    "phone" TEXT NOT NULL,
    "phone2" TEXT,
    "address" TEXT,
    "number" TEXT,
    "complement" TEXT,
    "neighborhood" TEXT,
    "city" TEXT,
    "state" TEXT,
    "zipCode" TEXT,
    "preferredContact" TEXT NOT NULL DEFAULT 'WHATSAPP',
    "preferredTime" TEXT,
    "totalSpent" DECIMAL(10,2) NOT NULL DEFAULT 0,
    "creditBalance" DECIMAL(10,2) NOT NULL DEFAULT 0,
    "hasDebt" BOOLEAN NOT NULL DEFAULT false,
    "acceptsMarketing" BOOLEAN NOT NULL DEFAULT true,
    "birthDate" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "lastVisitAt" TIMESTAMP(3),

    CONSTRAINT "tutors_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pets" (
    "id" TEXT NOT NULL,
    "businessId" TEXT NOT NULL,
    "tutorId" TEXT,
    "name" TEXT NOT NULL,
    "species" "Species" NOT NULL,
    "breed" TEXT,
    "size" "PetSize",
    "gender" "PetGender" NOT NULL DEFAULT 'UNKNOWN',
    "color" TEXT,
    "birthDate" TIMESTAMP(3),
    "estimatedAge" TEXT,
    "weight" DECIMAL(5,2),
    "microchipNumber" TEXT,
    "isNeutered" BOOLEAN NOT NULL DEFAULT false,
    "neuteredDate" TIMESTAMP(3),
    "photoUrl" TEXT,
    "photos" TEXT[],
    "allergies" TEXT[],
    "chronicConditions" TEXT[],
    "dietaryRestrictions" TEXT,
    "observations" TEXT,
    "temperament" TEXT,
    "socialization" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "isDeceased" BOOLEAN NOT NULL DEFAULT false,
    "deceasedDate" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "pets_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "medical_records" (
    "id" TEXT NOT NULL,
    "businessId" TEXT NOT NULL,
    "petId" TEXT NOT NULL,
    "vetId" TEXT NOT NULL,
    "appointmentId" TEXT,
    "recordDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "recordType" TEXT NOT NULL,
    "weight" DECIMAL(5,2),
    "temperature" DECIMAL(4,1),
    "heartRate" INTEGER,
    "respiratoryRate" INTEGER,
    "hydration" TEXT,
    "bodyCondition" INTEGER,
    "chiefComplaint" TEXT,
    "historyPresent" TEXT,
    "physicalExam" TEXT,
    "diagnosis" TEXT,
    "differentialDiagnosis" TEXT[],
    "treatment" TEXT,
    "prescription" JSONB,
    "examsRequested" TEXT[],
    "procedures" TEXT[],
    "instructions" TEXT,
    "returnDate" TIMESTAMP(3),
    "prognosis" TEXT,
    "attachments" TEXT[],
    "images" TEXT[],
    "isHospitalized" BOOLEAN NOT NULL DEFAULT false,
    "admissionDate" TIMESTAMP(3),
    "dischargeDate" TIMESTAMP(3),
    "hospitalizationNotes" TEXT,
    "isSurgical" BOOLEAN NOT NULL DEFAULT false,
    "surgeryType" TEXT,
    "anesthesiaType" TEXT,
    "surgeryNotes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "medical_records_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "prescriptions" (
    "id" TEXT NOT NULL,
    "medicalRecordId" TEXT NOT NULL,
    "medication" TEXT NOT NULL,
    "concentration" TEXT,
    "form" TEXT,
    "dosage" TEXT NOT NULL,
    "frequency" TEXT NOT NULL,
    "duration" TEXT NOT NULL,
    "route" TEXT,
    "instructions" TEXT,
    "isControlled" BOOLEAN NOT NULL DEFAULT false,
    "quantity" INTEGER,
    "refills" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "prescriptions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "vaccine_records" (
    "id" TEXT NOT NULL,
    "businessId" TEXT NOT NULL,
    "petId" TEXT NOT NULL,
    "vetId" TEXT NOT NULL,
    "appointmentId" TEXT,
    "vaccineType" "VaccineType" NOT NULL,
    "vaccineName" TEXT NOT NULL,
    "manufacturer" TEXT,
    "batchNumber" TEXT,
    "applicationDate" TIMESTAMP(3) NOT NULL,
    "expirationDate" TIMESTAMP(3),
    "nextDoseDate" TIMESTAMP(3),
    "nextDoseType" "VaccineType",
    "reminderSent30d" BOOLEAN NOT NULL DEFAULT false,
    "reminderSent7d" BOOLEAN NOT NULL DEFAULT false,
    "reminderSentDay" BOOLEAN NOT NULL DEFAULT false,
    "hadReaction" BOOLEAN NOT NULL DEFAULT false,
    "reactionNotes" TEXT,
    "certificateUrl" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "vaccine_records_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "adoption_animals" (
    "id" TEXT NOT NULL,
    "businessId" TEXT NOT NULL,
    "petId" TEXT NOT NULL,
    "rescueDate" TIMESTAMP(3),
    "rescueLocation" TEXT,
    "rescueStory" TEXT,
    "previousOwner" TEXT,
    "status" "AdoptionStatus" NOT NULL DEFAULT 'AVAILABLE',
    "availableDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "adoptedDate" TIMESTAMP(3),
    "isVaccinated" BOOLEAN NOT NULL DEFAULT false,
    "isNeutered" BOOLEAN NOT NULL DEFAULT false,
    "isDewormed" BOOLEAN NOT NULL DEFAULT false,
    "healthNotes" TEXT,
    "goodWithKids" BOOLEAN,
    "goodWithDogs" BOOLEAN,
    "goodWithCats" BOOLEAN,
    "apartmentFriendly" BOOLEAN,
    "energyLevel" TEXT,
    "trainingLevel" TEXT,
    "requirements" TEXT,
    "adoptionFee" DECIMAL(10,2),
    "videoUrl" TEXT,
    "description" TEXT,
    "isPublished" BOOLEAN NOT NULL DEFAULT true,
    "publishedOnSite" BOOLEAN NOT NULL DEFAULT true,
    "featuredUntil" TIMESTAMP(3),
    "viewCount" INTEGER NOT NULL DEFAULT 0,
    "inquiryCount" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "adoption_animals_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "adoption_inquiries" (
    "id" TEXT NOT NULL,
    "adoptionAnimalId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT,
    "phone" TEXT NOT NULL,
    "message" TEXT,
    "status" TEXT NOT NULL DEFAULT 'NEW',
    "rejectionReason" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "contactedAt" TIMESTAMP(3),

    CONSTRAINT "adoption_inquiries_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "adoptions" (
    "id" TEXT NOT NULL,
    "adoptionAnimalId" TEXT NOT NULL,
    "tutorId" TEXT NOT NULL,
    "applicationDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "interviewDate" TIMESTAMP(3),
    "homeVisitDate" TIMESTAMP(3),
    "adoptionDate" TIMESTAMP(3),
    "questionnaire" JSONB,
    "stage" TEXT NOT NULL DEFAULT 'APPLICATION',
    "stageNotes" TEXT,
    "agreementUrl" TEXT,
    "signedAt" TIMESTAMP(3),
    "followUp7d" TIMESTAMP(3),
    "followUp7dNotes" TEXT,
    "followUp30d" TIMESTAMP(3),
    "followUp30dNotes" TEXT,
    "followUp90d" TIMESTAMP(3),
    "followUp90dNotes" TEXT,
    "returnDate" TIMESTAMP(3),
    "returnReason" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "adoptions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "boarding_rooms" (
    "id" TEXT NOT NULL,
    "businessId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT,
    "roomType" "RoomType" NOT NULL DEFAULT 'INDIVIDUAL',
    "acceptedSpecies" "Species"[],
    "acceptedSizes" "PetSize"[],
    "capacity" INTEGER NOT NULL DEFAULT 1,
    "dailyRate" DECIMAL(10,2) NOT NULL,
    "extraPetRate" DECIMAL(10,2),
    "amenities" TEXT[],
    "hasCamera" BOOLEAN NOT NULL DEFAULT false,
    "cameraUrl" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "boarding_rooms_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "boardings" (
    "id" TEXT NOT NULL,
    "businessId" TEXT NOT NULL,
    "tutorId" TEXT NOT NULL,
    "petId" TEXT NOT NULL,
    "roomId" TEXT NOT NULL,
    "checkInDate" TIMESTAMP(3) NOT NULL,
    "checkInTime" TEXT,
    "checkOutDate" TIMESTAMP(3) NOT NULL,
    "checkOutTime" TEXT,
    "status" "BoardingStatus" NOT NULL DEFAULT 'RESERVED',
    "actualCheckIn" TIMESTAMP(3),
    "actualCheckOut" TIMESTAMP(3),
    "dailyRate" DECIMAL(10,2) NOT NULL,
    "totalDays" INTEGER NOT NULL,
    "subtotal" DECIMAL(10,2) NOT NULL,
    "extraServices" DECIMAL(10,2) NOT NULL DEFAULT 0,
    "discount" DECIMAL(10,2) NOT NULL DEFAULT 0,
    "totalAmount" DECIMAL(10,2) NOT NULL,
    "paymentStatus" "PaymentStatus" NOT NULL DEFAULT 'PENDING',
    "paidAmount" DECIMAL(10,2) NOT NULL DEFAULT 0,
    "feedingSchedule" TEXT,
    "foodType" TEXT,
    "foodAmount" TEXT,
    "medications" JSONB,
    "specialNeeds" TEXT,
    "emergencyContact" TEXT,
    "emergencyPhone" TEXT,
    "vetName" TEXT,
    "vetPhone" TEXT,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "boardings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "boarding_updates" (
    "id" TEXT NOT NULL,
    "boardingId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "updateType" TEXT NOT NULL,
    "content" TEXT,
    "photos" TEXT[],
    "videoUrl" TEXT,
    "sentToTutor" BOOLEAN NOT NULL DEFAULT false,
    "sentAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "boarding_updates_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "boarding_services" (
    "id" TEXT NOT NULL,
    "boardingId" TEXT NOT NULL,
    "serviceName" TEXT NOT NULL,
    "serviceDate" TIMESTAMP(3) NOT NULL,
    "price" DECIMAL(10,2) NOT NULL,
    "isCompleted" BOOLEAN NOT NULL DEFAULT false,
    "completedAt" TIMESTAMP(3),
    "notes" TEXT,

    CONSTRAINT "boarding_services_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "daycare_packages" (
    "id" TEXT NOT NULL,
    "businessId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "packageType" TEXT NOT NULL,
    "daysIncluded" INTEGER,
    "validityDays" INTEGER,
    "shift" TEXT NOT NULL,
    "price" DECIMAL(10,2) NOT NULL,
    "activities" TEXT[],
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "daycare_packages_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "daycare_enrollments" (
    "id" TEXT NOT NULL,
    "packageId" TEXT NOT NULL,
    "tutorId" TEXT NOT NULL,
    "petId" TEXT NOT NULL,
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3),
    "totalCredits" INTEGER NOT NULL DEFAULT 0,
    "usedCredits" INTEGER NOT NULL DEFAULT 0,
    "remainingCredits" INTEGER NOT NULL DEFAULT 0,
    "amount" DECIMAL(10,2) NOT NULL,
    "paymentStatus" "PaymentStatus" NOT NULL DEFAULT 'PENDING',
    "paidAt" TIMESTAMP(3),
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "daycare_enrollments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "daycare_attendances" (
    "id" TEXT NOT NULL,
    "enrollmentId" TEXT NOT NULL,
    "date" DATE NOT NULL,
    "checkInTime" TIMESTAMP(3),
    "checkOutTime" TIMESTAMP(3),
    "status" TEXT NOT NULL DEFAULT 'SCHEDULED',
    "behaviorNotes" TEXT,
    "activities" TEXT[],
    "feedingNotes" TEXT,
    "photos" TEXT[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "daycare_attendances_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "services" (
    "id" TEXT NOT NULL,
    "businessId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "category" TEXT NOT NULL,
    "duration" INTEGER NOT NULL,
    "price" DECIMAL(10,2) NOT NULL,
    "priceBySize" JSONB,
    "acceptedSpecies" "Species"[],
    "acceptedSizes" "PetSize"[],
    "requiresVet" BOOLEAN NOT NULL DEFAULT false,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "services_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "appointments" (
    "id" TEXT NOT NULL,
    "businessId" TEXT NOT NULL,
    "tutorId" TEXT NOT NULL,
    "petId" TEXT NOT NULL,
    "serviceId" TEXT NOT NULL,
    "professionalId" TEXT NOT NULL,
    "appointmentType" "AppointmentType" NOT NULL,
    "scheduledDate" TIMESTAMP(3) NOT NULL,
    "scheduledTime" TEXT NOT NULL,
    "duration" INTEGER NOT NULL,
    "endTime" TEXT,
    "status" "AppointmentStatus" NOT NULL DEFAULT 'SCHEDULED',
    "confirmedAt" TIMESTAMP(3),
    "startedAt" TIMESTAMP(3),
    "completedAt" TIMESTAMP(3),
    "cancelledAt" TIMESTAMP(3),
    "cancellationReason" TEXT,
    "price" DECIMAL(10,2) NOT NULL,
    "discount" DECIMAL(10,2) NOT NULL DEFAULT 0,
    "finalPrice" DECIMAL(10,2) NOT NULL,
    "paymentStatus" "PaymentStatus" NOT NULL DEFAULT 'PENDING',
    "paymentMethod" "PaymentMethod",
    "paidAt" TIMESTAMP(3),
    "reminder24hSent" BOOLEAN NOT NULL DEFAULT false,
    "reminder2hSent" BOOLEAN NOT NULL DEFAULT false,
    "notes" TEXT,
    "internalNotes" TEXT,
    "isRecurring" BOOLEAN NOT NULL DEFAULT false,
    "recurrenceRule" TEXT,
    "parentAppointmentId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "appointments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "products" (
    "id" TEXT NOT NULL,
    "businessId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "brand" TEXT,
    "sku" TEXT,
    "barcode" TEXT,
    "category" TEXT NOT NULL,
    "subcategory" TEXT,
    "forSpecies" "Species"[],
    "costPrice" DECIMAL(10,2) NOT NULL,
    "salePrice" DECIMAL(10,2) NOT NULL,
    "promotionalPrice" DECIMAL(10,2),
    "promotionEndsAt" TIMESTAMP(3),
    "currentStock" DECIMAL(10,3) NOT NULL DEFAULT 0,
    "minStock" DECIMAL(10,3) NOT NULL DEFAULT 0,
    "maxStock" DECIMAL(10,3),
    "unit" TEXT NOT NULL DEFAULT 'un',
    "expirationDate" TIMESTAMP(3),
    "alertDaysBefore" INTEGER NOT NULL DEFAULT 30,
    "supplierId" TEXT,
    "supplierCode" TEXT,
    "imageUrl" TEXT,
    "images" TEXT[],
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "isFeatured" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "products_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "stock_movements" (
    "id" TEXT NOT NULL,
    "productId" TEXT NOT NULL,
    "type" "StockMovementType" NOT NULL,
    "quantity" DECIMAL(10,3) NOT NULL,
    "previousStock" DECIMAL(10,3) NOT NULL,
    "newStock" DECIMAL(10,3) NOT NULL,
    "unitCost" DECIMAL(10,2),
    "totalCost" DECIMAL(10,2),
    "saleId" TEXT,
    "appointmentId" TEXT,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "stock_movements_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sales" (
    "id" TEXT NOT NULL,
    "businessId" TEXT NOT NULL,
    "tutorId" TEXT,
    "userId" TEXT NOT NULL,
    "subtotal" DECIMAL(10,2) NOT NULL,
    "discount" DECIMAL(10,2) NOT NULL DEFAULT 0,
    "totalAmount" DECIMAL(10,2) NOT NULL,
    "paymentMethod" "PaymentMethod" NOT NULL,
    "paymentStatus" "PaymentStatus" NOT NULL DEFAULT 'PAID',
    "installments" INTEGER NOT NULL DEFAULT 1,
    "invoiceNumber" TEXT,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "sales_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sale_items" (
    "id" TEXT NOT NULL,
    "saleId" TEXT NOT NULL,
    "productId" TEXT,
    "description" TEXT NOT NULL,
    "quantity" DECIMAL(10,3) NOT NULL,
    "unitPrice" DECIMAL(10,2) NOT NULL,
    "discount" DECIMAL(10,2) NOT NULL DEFAULT 0,
    "totalPrice" DECIMAL(10,2) NOT NULL,
    "itemType" TEXT NOT NULL,

    CONSTRAINT "sale_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "cash_registers" (
    "id" TEXT NOT NULL,
    "businessId" TEXT NOT NULL,
    "date" DATE NOT NULL,
    "cashTotal" DECIMAL(10,2) NOT NULL DEFAULT 0,
    "pixTotal" DECIMAL(10,2) NOT NULL DEFAULT 0,
    "creditTotal" DECIMAL(10,2) NOT NULL DEFAULT 0,
    "debitTotal" DECIMAL(10,2) NOT NULL DEFAULT 0,
    "totalRevenue" DECIMAL(10,2) NOT NULL DEFAULT 0,
    "totalExpenses" DECIMAL(10,2) NOT NULL DEFAULT 0,
    "netAmount" DECIMAL(10,2) NOT NULL DEFAULT 0,
    "salesCount" INTEGER NOT NULL DEFAULT 0,
    "servicesCount" INTEGER NOT NULL DEFAULT 0,
    "isClosed" BOOLEAN NOT NULL DEFAULT false,
    "closedAt" TIMESTAMP(3),
    "closedById" TEXT,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "cash_registers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "campaigns" (
    "id" TEXT NOT NULL,
    "businessId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "message" TEXT NOT NULL,
    "segmentType" TEXT,
    "customFilter" JSONB,
    "status" TEXT NOT NULL DEFAULT 'DRAFT',
    "scheduledFor" TIMESTAMP(3),
    "completedAt" TIMESTAMP(3),
    "totalRecipients" INTEGER NOT NULL DEFAULT 0,
    "sentCount" INTEGER NOT NULL DEFAULT 0,
    "failedCount" INTEGER NOT NULL DEFAULT 0,
    "responseCount" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "campaigns_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "whatsapp_messages" (
    "id" TEXT NOT NULL,
    "businessId" TEXT NOT NULL,
    "remoteJid" TEXT NOT NULL,
    "messageId" TEXT,
    "direction" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "mediaUrl" TEXT,
    "mediaType" TEXT,
    "tutorId" TEXT,
    "petId" TEXT,
    "appointmentId" TEXT,
    "status" TEXT NOT NULL DEFAULT 'SENT',
    "sentAt" TIMESTAMP(3),
    "deliveredAt" TIMESTAMP(3),
    "readAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "whatsapp_messages_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "message_templates" (
    "id" TEXT NOT NULL,
    "businessId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "variables" TEXT[],
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "message_templates_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pet_sitters" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "cpf" TEXT,
    "passwordHash" TEXT,
    "bio" TEXT,
    "photoUrl" TEXT,
    "photos" TEXT[],
    "address" TEXT,
    "city" TEXT,
    "state" TEXT,
    "zipCode" TEXT,
    "latitude" DECIMAL(10,8),
    "longitude" DECIMAL(11,8),
    "serviceRadius" INTEGER NOT NULL DEFAULT 10,
    "acceptedSpecies" "Species"[],
    "acceptedSizes" "PetSize"[],
    "experience" TEXT,
    "certifications" TEXT[],
    "hasOwnTransport" BOOLEAN NOT NULL DEFAULT false,
    "hasYard" BOOLEAN NOT NULL DEFAULT false,
    "hasOtherPets" BOOLEAN NOT NULL DEFAULT false,
    "otherPetsDetails" TEXT,
    "status" "PetSitterStatus" NOT NULL DEFAULT 'PENDING_APPROVAL',
    "approvedAt" TIMESTAMP(3),
    "rejectionReason" TEXT,
    "documentsUrl" TEXT[],
    "backgroundCheckUrl" TEXT,
    "averageRating" DECIMAL(3,2) NOT NULL DEFAULT 0,
    "totalReviews" INTEGER NOT NULL DEFAULT 0,
    "totalBookings" INTEGER NOT NULL DEFAULT 0,
    "responseTime" INTEGER,
    "responseRate" DECIMAL(5,2),
    "isVerified" BOOLEAN NOT NULL DEFAULT false,
    "isFeatured" BOOLEAN NOT NULL DEFAULT false,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "bankName" TEXT,
    "bankAgency" TEXT,
    "bankAccount" TEXT,
    "pixKey" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "pet_sitters_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pet_sitter_services" (
    "id" TEXT NOT NULL,
    "petSitterId" TEXT NOT NULL,
    "serviceType" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "priceType" TEXT NOT NULL,
    "price" DECIMAL(10,2) NOT NULL,
    "pricePerSize" JSONB,
    "duration" INTEGER,
    "maxPets" INTEGER NOT NULL DEFAULT 1,
    "includesFood" BOOLEAN NOT NULL DEFAULT false,
    "includesMeds" BOOLEAN NOT NULL DEFAULT false,
    "availability" JSONB,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "pet_sitter_services_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pet_sitter_bookings" (
    "id" TEXT NOT NULL,
    "petSitterId" TEXT NOT NULL,
    "serviceId" TEXT NOT NULL,
    "tutorName" TEXT NOT NULL,
    "tutorEmail" TEXT,
    "tutorPhone" TEXT NOT NULL,
    "petName" TEXT NOT NULL,
    "petSpecies" "Species" NOT NULL,
    "petSize" "PetSize",
    "petAge" TEXT,
    "petNotes" TEXT,
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3),
    "startTime" TEXT,
    "endTime" TEXT,
    "totalDays" INTEGER,
    "totalHours" DECIMAL(5,2),
    "pricePerUnit" DECIMAL(10,2) NOT NULL,
    "subtotal" DECIMAL(10,2) NOT NULL,
    "serviceFee" DECIMAL(10,2) NOT NULL DEFAULT 0,
    "totalAmount" DECIMAL(10,2) NOT NULL,
    "sitterPayout" DECIMAL(10,2) NOT NULL,
    "status" "BookingStatus" NOT NULL DEFAULT 'PENDING',
    "confirmedAt" TIMESTAMP(3),
    "cancelledAt" TIMESTAMP(3),
    "cancellationReason" TEXT,
    "cancelledBy" TEXT,
    "paymentStatus" "PaymentStatus" NOT NULL DEFAULT 'PENDING',
    "paymentMethod" TEXT,
    "paidAt" TIMESTAMP(3),
    "payoutStatus" TEXT NOT NULL DEFAULT 'PENDING',
    "paidOutAt" TIMESTAMP(3),
    "specialRequests" TEXT,
    "emergencyContact" TEXT,
    "emergencyPhone" TEXT,
    "vetName" TEXT,
    "vetPhone" TEXT,
    "feedingInstructions" TEXT,
    "medicationInstructions" TEXT,
    "updates" JSONB,
    "completedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "pet_sitter_bookings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pet_sitter_reviews" (
    "id" TEXT NOT NULL,
    "bookingId" TEXT NOT NULL,
    "petSitterId" TEXT NOT NULL,
    "rating" INTEGER NOT NULL,
    "title" TEXT,
    "comment" TEXT,
    "photos" TEXT[],
    "response" TEXT,
    "respondedAt" TIMESTAMP(3),
    "isVerified" BOOLEAN NOT NULL DEFAULT true,
    "isPublished" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "pet_sitter_reviews_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "marketplace_sellers" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "cpfCnpj" TEXT,
    "passwordHash" TEXT,
    "companyName" TEXT,
    "description" TEXT,
    "logoUrl" TEXT,
    "bannerUrl" TEXT,
    "address" TEXT,
    "city" TEXT,
    "state" TEXT,
    "zipCode" TEXT,
    "sellerType" TEXT NOT NULL,
    "isVerified" BOOLEAN NOT NULL DEFAULT false,
    "isFeatured" BOOLEAN NOT NULL DEFAULT false,
    "averageRating" DECIMAL(3,2) NOT NULL DEFAULT 0,
    "totalReviews" INTEGER NOT NULL DEFAULT 0,
    "totalSales" INTEGER NOT NULL DEFAULT 0,
    "totalRevenue" DECIMAL(12,2) NOT NULL DEFAULT 0,
    "commissionRate" DECIMAL(5,2) NOT NULL DEFAULT 10,
    "bankName" TEXT,
    "bankAgency" TEXT,
    "bankAccount" TEXT,
    "pixKey" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "approvedAt" TIMESTAMP(3),
    "suspendedAt" TIMESTAMP(3),
    "suspendedReason" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "marketplace_sellers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "marketplace_categories" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "description" TEXT,
    "imageUrl" TEXT,
    "parentId" TEXT,
    "order" INTEGER NOT NULL DEFAULT 0,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "marketplace_categories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "marketplace_listings" (
    "id" TEXT NOT NULL,
    "sellerId" TEXT NOT NULL,
    "categoryId" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "shortDescription" TEXT,
    "brand" TEXT,
    "sku" TEXT,
    "barcode" TEXT,
    "forSpecies" "Species"[],
    "forSizes" "PetSize"[],
    "price" DECIMAL(10,2) NOT NULL,
    "compareAtPrice" DECIMAL(10,2),
    "costPrice" DECIMAL(10,2),
    "stock" INTEGER NOT NULL DEFAULT 0,
    "lowStockThreshold" INTEGER NOT NULL DEFAULT 5,
    "weight" DECIMAL(10,3),
    "dimensions" TEXT,
    "images" TEXT[],
    "videoUrl" TEXT,
    "tags" TEXT[],
    "attributes" JSONB,
    "nutritionInfo" JSONB,
    "ingredients" TEXT,
    "expirationDate" TIMESTAMP(3),
    "shippingType" TEXT NOT NULL DEFAULT 'STANDARD',
    "freeShipping" BOOLEAN NOT NULL DEFAULT false,
    "shippingPrice" DECIMAL(10,2),
    "status" "ListingStatus" NOT NULL DEFAULT 'DRAFT',
    "rejectionReason" TEXT,
    "publishedAt" TIMESTAMP(3),
    "featuredUntil" TIMESTAMP(3),
    "viewCount" INTEGER NOT NULL DEFAULT 0,
    "favoriteCount" INTEGER NOT NULL DEFAULT 0,
    "salesCount" INTEGER NOT NULL DEFAULT 0,
    "averageRating" DECIMAL(3,2) NOT NULL DEFAULT 0,
    "totalReviews" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "marketplace_listings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "marketplace_orders" (
    "id" TEXT NOT NULL,
    "sellerId" TEXT NOT NULL,
    "orderNumber" TEXT NOT NULL,
    "buyerName" TEXT NOT NULL,
    "buyerEmail" TEXT NOT NULL,
    "buyerPhone" TEXT NOT NULL,
    "buyerCpf" TEXT,
    "shippingAddress" TEXT NOT NULL,
    "shippingCity" TEXT NOT NULL,
    "shippingState" TEXT NOT NULL,
    "shippingZipCode" TEXT NOT NULL,
    "subtotal" DECIMAL(10,2) NOT NULL,
    "shippingCost" DECIMAL(10,2) NOT NULL DEFAULT 0,
    "discount" DECIMAL(10,2) NOT NULL DEFAULT 0,
    "totalAmount" DECIMAL(10,2) NOT NULL,
    "commission" DECIMAL(10,2) NOT NULL,
    "sellerPayout" DECIMAL(10,2) NOT NULL,
    "paymentMethod" TEXT NOT NULL,
    "paymentStatus" "PaymentStatus" NOT NULL DEFAULT 'PENDING',
    "paidAt" TIMESTAMP(3),
    "payoutStatus" TEXT NOT NULL DEFAULT 'PENDING',
    "paidOutAt" TIMESTAMP(3),
    "status" TEXT NOT NULL DEFAULT 'PENDING',
    "shippedAt" TIMESTAMP(3),
    "trackingCode" TEXT,
    "trackingUrl" TEXT,
    "deliveredAt" TIMESTAMP(3),
    "cancelledAt" TIMESTAMP(3),
    "cancellationReason" TEXT,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "marketplace_orders_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "marketplace_order_items" (
    "id" TEXT NOT NULL,
    "orderId" TEXT NOT NULL,
    "listingId" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "sku" TEXT,
    "quantity" INTEGER NOT NULL,
    "unitPrice" DECIMAL(10,2) NOT NULL,
    "totalPrice" DECIMAL(10,2) NOT NULL,

    CONSTRAINT "marketplace_order_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "marketplace_reviews" (
    "id" TEXT NOT NULL,
    "listingId" TEXT NOT NULL,
    "sellerId" TEXT NOT NULL,
    "buyerName" TEXT NOT NULL,
    "buyerEmail" TEXT,
    "rating" INTEGER NOT NULL,
    "title" TEXT,
    "comment" TEXT,
    "photos" TEXT[],
    "isVerified" BOOLEAN NOT NULL DEFAULT false,
    "isPublished" BOOLEAN NOT NULL DEFAULT true,
    "response" TEXT,
    "respondedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "marketplace_reviews_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "businesses_slug_key" ON "businesses"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "businesses_cnpj_key" ON "businesses"("cnpj");

-- CreateIndex
CREATE UNIQUE INDEX "users_businessId_email_key" ON "users"("businessId", "email");

-- CreateIndex
CREATE INDEX "tutors_businessId_phone_idx" ON "tutors"("businessId", "phone");

-- CreateIndex
CREATE UNIQUE INDEX "tutors_businessId_cpf_key" ON "tutors"("businessId", "cpf");

-- CreateIndex
CREATE INDEX "pets_businessId_idx" ON "pets"("businessId");

-- CreateIndex
CREATE INDEX "pets_tutorId_idx" ON "pets"("tutorId");

-- CreateIndex
CREATE INDEX "medical_records_businessId_idx" ON "medical_records"("businessId");

-- CreateIndex
CREATE INDEX "medical_records_petId_idx" ON "medical_records"("petId");

-- CreateIndex
CREATE INDEX "medical_records_vetId_idx" ON "medical_records"("vetId");

-- CreateIndex
CREATE INDEX "vaccine_records_businessId_idx" ON "vaccine_records"("businessId");

-- CreateIndex
CREATE INDEX "vaccine_records_petId_idx" ON "vaccine_records"("petId");

-- CreateIndex
CREATE INDEX "vaccine_records_nextDoseDate_idx" ON "vaccine_records"("nextDoseDate");

-- CreateIndex
CREATE UNIQUE INDEX "adoption_animals_petId_key" ON "adoption_animals"("petId");

-- CreateIndex
CREATE INDEX "adoption_animals_businessId_status_idx" ON "adoption_animals"("businessId", "status");

-- CreateIndex
CREATE INDEX "adoption_inquiries_adoptionAnimalId_idx" ON "adoption_inquiries"("adoptionAnimalId");

-- CreateIndex
CREATE INDEX "adoptions_adoptionAnimalId_idx" ON "adoptions"("adoptionAnimalId");

-- CreateIndex
CREATE INDEX "adoptions_tutorId_idx" ON "adoptions"("tutorId");

-- CreateIndex
CREATE UNIQUE INDEX "boarding_rooms_businessId_name_key" ON "boarding_rooms"("businessId", "name");

-- CreateIndex
CREATE INDEX "boardings_businessId_status_idx" ON "boardings"("businessId", "status");

-- CreateIndex
CREATE INDEX "boardings_roomId_checkInDate_checkOutDate_idx" ON "boardings"("roomId", "checkInDate", "checkOutDate");

-- CreateIndex
CREATE INDEX "boarding_updates_boardingId_idx" ON "boarding_updates"("boardingId");

-- CreateIndex
CREATE INDEX "daycare_enrollments_tutorId_idx" ON "daycare_enrollments"("tutorId");

-- CreateIndex
CREATE INDEX "daycare_enrollments_petId_idx" ON "daycare_enrollments"("petId");

-- CreateIndex
CREATE UNIQUE INDEX "daycare_attendances_enrollmentId_date_key" ON "daycare_attendances"("enrollmentId", "date");

-- CreateIndex
CREATE INDEX "services_businessId_idx" ON "services"("businessId");

-- CreateIndex
CREATE INDEX "appointments_businessId_scheduledDate_idx" ON "appointments"("businessId", "scheduledDate");

-- CreateIndex
CREATE INDEX "appointments_professionalId_scheduledDate_idx" ON "appointments"("professionalId", "scheduledDate");

-- CreateIndex
CREATE INDEX "appointments_petId_idx" ON "appointments"("petId");

-- CreateIndex
CREATE INDEX "appointments_status_idx" ON "appointments"("status");

-- CreateIndex
CREATE INDEX "products_businessId_category_idx" ON "products"("businessId", "category");

-- CreateIndex
CREATE UNIQUE INDEX "products_businessId_sku_key" ON "products"("businessId", "sku");

-- CreateIndex
CREATE INDEX "stock_movements_productId_idx" ON "stock_movements"("productId");

-- CreateIndex
CREATE INDEX "sales_businessId_createdAt_idx" ON "sales"("businessId", "createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "cash_registers_businessId_date_key" ON "cash_registers"("businessId", "date");

-- CreateIndex
CREATE INDEX "campaigns_businessId_status_idx" ON "campaigns"("businessId", "status");

-- CreateIndex
CREATE UNIQUE INDEX "whatsapp_messages_messageId_key" ON "whatsapp_messages"("messageId");

-- CreateIndex
CREATE INDEX "whatsapp_messages_businessId_idx" ON "whatsapp_messages"("businessId");

-- CreateIndex
CREATE INDEX "whatsapp_messages_remoteJid_idx" ON "whatsapp_messages"("remoteJid");

-- CreateIndex
CREATE UNIQUE INDEX "message_templates_businessId_type_key" ON "message_templates"("businessId", "type");

-- CreateIndex
CREATE UNIQUE INDEX "pet_sitters_email_key" ON "pet_sitters"("email");

-- CreateIndex
CREATE UNIQUE INDEX "pet_sitters_cpf_key" ON "pet_sitters"("cpf");

-- CreateIndex
CREATE INDEX "pet_sitters_city_state_idx" ON "pet_sitters"("city", "state");

-- CreateIndex
CREATE INDEX "pet_sitters_status_idx" ON "pet_sitters"("status");

-- CreateIndex
CREATE INDEX "pet_sitter_services_petSitterId_idx" ON "pet_sitter_services"("petSitterId");

-- CreateIndex
CREATE INDEX "pet_sitter_bookings_petSitterId_status_idx" ON "pet_sitter_bookings"("petSitterId", "status");

-- CreateIndex
CREATE INDEX "pet_sitter_bookings_status_idx" ON "pet_sitter_bookings"("status");

-- CreateIndex
CREATE UNIQUE INDEX "pet_sitter_reviews_bookingId_key" ON "pet_sitter_reviews"("bookingId");

-- CreateIndex
CREATE INDEX "pet_sitter_reviews_petSitterId_idx" ON "pet_sitter_reviews"("petSitterId");

-- CreateIndex
CREATE UNIQUE INDEX "marketplace_sellers_email_key" ON "marketplace_sellers"("email");

-- CreateIndex
CREATE UNIQUE INDEX "marketplace_sellers_cpfCnpj_key" ON "marketplace_sellers"("cpfCnpj");

-- CreateIndex
CREATE INDEX "marketplace_sellers_city_state_idx" ON "marketplace_sellers"("city", "state");

-- CreateIndex
CREATE UNIQUE INDEX "marketplace_categories_slug_key" ON "marketplace_categories"("slug");

-- CreateIndex
CREATE INDEX "marketplace_listings_categoryId_idx" ON "marketplace_listings"("categoryId");

-- CreateIndex
CREATE INDEX "marketplace_listings_status_idx" ON "marketplace_listings"("status");

-- CreateIndex
CREATE INDEX "marketplace_listings_forSpecies_idx" ON "marketplace_listings"("forSpecies");

-- CreateIndex
CREATE UNIQUE INDEX "marketplace_listings_sellerId_slug_key" ON "marketplace_listings"("sellerId", "slug");

-- CreateIndex
CREATE UNIQUE INDEX "marketplace_orders_orderNumber_key" ON "marketplace_orders"("orderNumber");

-- CreateIndex
CREATE INDEX "marketplace_orders_sellerId_idx" ON "marketplace_orders"("sellerId");

-- CreateIndex
CREATE INDEX "marketplace_orders_status_idx" ON "marketplace_orders"("status");

-- CreateIndex
CREATE INDEX "marketplace_reviews_listingId_idx" ON "marketplace_reviews"("listingId");

-- CreateIndex
CREATE INDEX "marketplace_reviews_sellerId_idx" ON "marketplace_reviews"("sellerId");

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "businesses"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tutors" ADD CONSTRAINT "tutors_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "businesses"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pets" ADD CONSTRAINT "pets_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "businesses"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pets" ADD CONSTRAINT "pets_tutorId_fkey" FOREIGN KEY ("tutorId") REFERENCES "tutors"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "medical_records" ADD CONSTRAINT "medical_records_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "businesses"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "medical_records" ADD CONSTRAINT "medical_records_petId_fkey" FOREIGN KEY ("petId") REFERENCES "pets"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "medical_records" ADD CONSTRAINT "medical_records_vetId_fkey" FOREIGN KEY ("vetId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "medical_records" ADD CONSTRAINT "medical_records_appointmentId_fkey" FOREIGN KEY ("appointmentId") REFERENCES "appointments"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "prescriptions" ADD CONSTRAINT "prescriptions_medicalRecordId_fkey" FOREIGN KEY ("medicalRecordId") REFERENCES "medical_records"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vaccine_records" ADD CONSTRAINT "vaccine_records_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "businesses"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vaccine_records" ADD CONSTRAINT "vaccine_records_petId_fkey" FOREIGN KEY ("petId") REFERENCES "pets"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vaccine_records" ADD CONSTRAINT "vaccine_records_vetId_fkey" FOREIGN KEY ("vetId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vaccine_records" ADD CONSTRAINT "vaccine_records_appointmentId_fkey" FOREIGN KEY ("appointmentId") REFERENCES "appointments"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "adoption_animals" ADD CONSTRAINT "adoption_animals_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "businesses"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "adoption_animals" ADD CONSTRAINT "adoption_animals_petId_fkey" FOREIGN KEY ("petId") REFERENCES "pets"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "adoption_inquiries" ADD CONSTRAINT "adoption_inquiries_adoptionAnimalId_fkey" FOREIGN KEY ("adoptionAnimalId") REFERENCES "adoption_animals"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "adoptions" ADD CONSTRAINT "adoptions_adoptionAnimalId_fkey" FOREIGN KEY ("adoptionAnimalId") REFERENCES "adoption_animals"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "adoptions" ADD CONSTRAINT "adoptions_tutorId_fkey" FOREIGN KEY ("tutorId") REFERENCES "tutors"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "boarding_rooms" ADD CONSTRAINT "boarding_rooms_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "businesses"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "boardings" ADD CONSTRAINT "boardings_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "businesses"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "boardings" ADD CONSTRAINT "boardings_tutorId_fkey" FOREIGN KEY ("tutorId") REFERENCES "tutors"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "boardings" ADD CONSTRAINT "boardings_petId_fkey" FOREIGN KEY ("petId") REFERENCES "pets"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "boardings" ADD CONSTRAINT "boardings_roomId_fkey" FOREIGN KEY ("roomId") REFERENCES "boarding_rooms"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "boarding_updates" ADD CONSTRAINT "boarding_updates_boardingId_fkey" FOREIGN KEY ("boardingId") REFERENCES "boardings"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "boarding_updates" ADD CONSTRAINT "boarding_updates_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "boarding_services" ADD CONSTRAINT "boarding_services_boardingId_fkey" FOREIGN KEY ("boardingId") REFERENCES "boardings"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "daycare_packages" ADD CONSTRAINT "daycare_packages_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "businesses"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "daycare_enrollments" ADD CONSTRAINT "daycare_enrollments_packageId_fkey" FOREIGN KEY ("packageId") REFERENCES "daycare_packages"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "daycare_enrollments" ADD CONSTRAINT "daycare_enrollments_tutorId_fkey" FOREIGN KEY ("tutorId") REFERENCES "tutors"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "daycare_enrollments" ADD CONSTRAINT "daycare_enrollments_petId_fkey" FOREIGN KEY ("petId") REFERENCES "pets"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "daycare_attendances" ADD CONSTRAINT "daycare_attendances_enrollmentId_fkey" FOREIGN KEY ("enrollmentId") REFERENCES "daycare_enrollments"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "services" ADD CONSTRAINT "services_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "businesses"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "appointments" ADD CONSTRAINT "appointments_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "businesses"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "appointments" ADD CONSTRAINT "appointments_tutorId_fkey" FOREIGN KEY ("tutorId") REFERENCES "tutors"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "appointments" ADD CONSTRAINT "appointments_petId_fkey" FOREIGN KEY ("petId") REFERENCES "pets"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "appointments" ADD CONSTRAINT "appointments_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES "services"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "appointments" ADD CONSTRAINT "appointments_professionalId_fkey" FOREIGN KEY ("professionalId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "products" ADD CONSTRAINT "products_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "businesses"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "stock_movements" ADD CONSTRAINT "stock_movements_productId_fkey" FOREIGN KEY ("productId") REFERENCES "products"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sales" ADD CONSTRAINT "sales_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "businesses"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sales" ADD CONSTRAINT "sales_tutorId_fkey" FOREIGN KEY ("tutorId") REFERENCES "tutors"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sales" ADD CONSTRAINT "sales_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sale_items" ADD CONSTRAINT "sale_items_saleId_fkey" FOREIGN KEY ("saleId") REFERENCES "sales"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sale_items" ADD CONSTRAINT "sale_items_productId_fkey" FOREIGN KEY ("productId") REFERENCES "products"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cash_registers" ADD CONSTRAINT "cash_registers_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "businesses"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "campaigns" ADD CONSTRAINT "campaigns_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "businesses"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "message_templates" ADD CONSTRAINT "message_templates_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "businesses"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pet_sitter_services" ADD CONSTRAINT "pet_sitter_services_petSitterId_fkey" FOREIGN KEY ("petSitterId") REFERENCES "pet_sitters"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pet_sitter_bookings" ADD CONSTRAINT "pet_sitter_bookings_petSitterId_fkey" FOREIGN KEY ("petSitterId") REFERENCES "pet_sitters"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pet_sitter_bookings" ADD CONSTRAINT "pet_sitter_bookings_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES "pet_sitter_services"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pet_sitter_reviews" ADD CONSTRAINT "pet_sitter_reviews_bookingId_fkey" FOREIGN KEY ("bookingId") REFERENCES "pet_sitter_bookings"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pet_sitter_reviews" ADD CONSTRAINT "pet_sitter_reviews_petSitterId_fkey" FOREIGN KEY ("petSitterId") REFERENCES "pet_sitters"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "marketplace_categories" ADD CONSTRAINT "marketplace_categories_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "marketplace_categories"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "marketplace_listings" ADD CONSTRAINT "marketplace_listings_sellerId_fkey" FOREIGN KEY ("sellerId") REFERENCES "marketplace_sellers"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "marketplace_listings" ADD CONSTRAINT "marketplace_listings_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "marketplace_categories"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "marketplace_orders" ADD CONSTRAINT "marketplace_orders_sellerId_fkey" FOREIGN KEY ("sellerId") REFERENCES "marketplace_sellers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "marketplace_order_items" ADD CONSTRAINT "marketplace_order_items_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "marketplace_orders"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "marketplace_order_items" ADD CONSTRAINT "marketplace_order_items_listingId_fkey" FOREIGN KEY ("listingId") REFERENCES "marketplace_listings"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "marketplace_reviews" ADD CONSTRAINT "marketplace_reviews_listingId_fkey" FOREIGN KEY ("listingId") REFERENCES "marketplace_listings"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "marketplace_reviews" ADD CONSTRAINT "marketplace_reviews_sellerId_fkey" FOREIGN KEY ("sellerId") REFERENCES "marketplace_sellers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

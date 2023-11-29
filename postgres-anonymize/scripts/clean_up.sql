-- A script to clean up the database initially in order to stay GDPR compliant.

-- ------------------ Clean up the database ------------------
-- Tasks related tables
DROP TABLE public."CampaignScrapeTasks";
DROP TABLE public."LeadScrapeTasks";
DROP TABLE public."HandleInboxTasks";
DROP TABLE public."SendInviteTasks";

DROP TABLE public."TrackEmailTasks";
DROP TABLE public."TargetMarketTasks";
DROP TABLE public."SendEmailTasks";

-- Tables related to the email feature
DROP TABLE public."Blacklists";
DROP TABLE public."ConversationMessages";
DROP TABLE public."Conversations";

-- Other
DROP TABLE public."ScraperAccounts";
DROP TABLE public."SequelizeMeta";

-- Remove FK constraints on the campaign table
-- Display them FK constraints
-- SELECT constraint_name FROM information_schema.table_constraints WHERE table_name='Campaigns' AND constraint_type='FOREIGN KEY';
ALTER TABLE public."Campaigns" DROP CONSTRAINT "Campaigns_emailId_fkey";
ALTER TABLE public."Campaigns" DROP CONSTRAINT "Campaigns_hostname_fkey";
ALTER TABLE public."Campaigns" DROP CONSTRAINT "Campaigns_linkedInAccountId_fkey";
ALTER TABLE public."Campaigns" DROP CONSTRAINT "Campaigns_targetMarketId_fkey";

-- ~~Workaround for faker not being able to generate unique emails~~ (Solved with scripts/unique_fake_email.sql)
-- ALTER TABLE public."Users" DROP CONSTRAINT "Users_email_key";

-- Drop the tables
DROP TABLE public."Emails";
DROP TABLE public."Machines";
DROP TABLE public."LinkedInAccounts";
DROP TABLE public."TargetMarkets";

-- ------------------ Further clean up some other fields ------------------
-- Users table
ALTER TABLE public."Users" DROP COLUMN "password";

-- Campaigns table
ALTER TABLE public."Campaigns"
    DROP COLUMN "campaignLink",
    DROP COLUMN "linkedInAccountId",
    DROP COLUMN "hostname",
    DROP COLUMN "emailFollowUpsSubject",
    DROP COLUMN "emailId",
    DROP COLUMN "targetMarketId",
    DROP COLUMN "overwriteEmailRecipientAddress",
    DROP COLUMN "femaleSalutation",
    DROP COLUMN "maleSalutation",
    DROP COLUMN "firstMessage",
    DROP COLUMN "secondMessage",
    DROP COLUMN "thirdMessage",
    DROP COLUMN "fourthMessage",
    DROP COLUMN "fifthMessage",
    DROP COLUMN "sixthMessage",
    DROP COLUMN "seventhMessage",
    DROP COLUMN "secondMessageInterval",
    DROP COLUMN "thirdMessageInterval",
    DROP COLUMN "fourthMessageInterval",
    DROP COLUMN "fifthMessageInterval",
    DROP COLUMN "sixthMessageInterval",
    DROP COLUMN "seventhMessageInterval";

-- Leads table
ALTER TABLE public."Leads"
    DROP COLUMN "leadId",
    DROP COLUMN "linkedInProfileUrl",
    DROP COLUMN "salesNavProfileUrl",
    DROP COLUMN "imageUrl",
    DROP COLUMN "companyUrl";

-- A script to anonymise the database.
-- See docs: https://postgresql-anonymizer.readthedocs.io/en/stable/masking_functions/

SELECT pg_catalog.set_config('search_path', 'public', false);

CREATE EXTENSION anon CASCADE;
SELECT anon.init();

-- Anonymize the "Users" table
SECURITY LABEL FOR anon ON COLUMN "Users"."email"
IS 'MASKED WITH FUNCTION public.unique_fake_email()';

SECURITY LABEL FOR anon ON COLUMN "Users"."companyName"
IS 'MASKED WITH FUNCTION anon.fake_company()';

-- Anonymize the "Campaigns" table
SECURITY LABEL FOR anon ON COLUMN "Campaigns"."name"
IS 'MASKED WITH FUNCTION anon.fake_company() || '' '' || anon.fake_company()';

-- Anonymize the "Leads" table
SECURITY LABEL FOR anon ON COLUMN "Leads"."firstName"
IS 'MASKED WITH FUNCTION anon.fake_first_name()';

SECURITY LABEL FOR anon ON COLUMN "Leads"."lastName"
IS 'MASKED WITH FUNCTION anon.fake_last_name()';

SECURITY LABEL FOR anon ON COLUMN "Leads"."name"
IS 'MASKED WITH FUNCTION anon.fake_first_name() || '' '' || anon.fake_last_name()';

-- Anonymize the "Messages" table (its content can include some names)

SELECT anon.anonymize_database();

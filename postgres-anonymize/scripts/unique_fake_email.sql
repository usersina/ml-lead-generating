CREATE OR REPLACE FUNCTION unique_fake_email() RETURNS text AS $$
DECLARE
  fake_email text;
BEGIN
  LOOP
    -- Generate a new fake email
    fake_email := anon.fake_email();

    -- Check if the email already exists in the Users table
    IF NOT EXISTS (SELECT 1 FROM public."Users" WHERE public."Users"."email" = fake_email) THEN
      -- If the email does not exist, exit the loop
      EXIT;
    END IF;
  END LOOP;

  -- Return the unique fake email
  RETURN fake_email;
END;
$$ LANGUAGE plpgsql;

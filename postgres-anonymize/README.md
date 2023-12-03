# Postgres Anonymize

This repository shows how to anonymize a PostgreSQL database using [PostgreSQL Anonymizer](https://postgresql-anonymizer.readthedocs.io/en/stable/).
The pattern used is easily scalable and reproducible no matter the data.

This will first show how to it manually, to get a hang of how the process works.
Then it shows how to automate it with a script.

## Requirements

- docker
- docker-compose

Additionally, [Taskfile](https://taskfile.dev/) is used to keep track of the commands. This is optional and the task file can be checked for the corresponding commands.

## I. Manual method

### 1. Getting started

Start by running the compose containers.

```bash
task up
```

This includes:

- A `postgresql` instance with the extension already installed and the data initially loaded.
- A `pgadmin` interface accessible at `http://127.0.0.1:8080`

Login information can checked from the compose file.

### 2. Testing the Anonymiser

- Connect to the local database in the `postgres-anonymiser` container

```bash
docker exec -it postgres-anonymiser bash -c "psql -U ilg -d ilg"
```

- Verify that the anonymiser is working

```sql
SELECT anon.partial_email('daamien@gmail.com');
```

### 3. Checking the database

- Check that we do have our database

```sql
SELECT column_name, data_type, character_maximum_length, column_default, is_nullable
FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = 'Leads';
```

- Show the leads data

```sql
SELECT "firstName", "lastName", "email" FROM "Leads";
```

### 4. Anonymizing

- The leads table

```sql
SECURITY LABEL FOR anon ON COLUMN "Leads"."firstName"
IS 'MASKED WITH FUNCTION anon.fake_first_name()';

SECURITY LABEL FOR anon ON COLUMN "Leads"."lastName"
IS 'MASKED WITH FUNCTION anon.fake_last_name()';

SELECT anon.anonymize_database();
```

And you would continue anonymizing all other fields where necessary.

### 5. Resetting the database

For another round of tests, you can reset the database

```bash
docker compose stop postgres-anonymiser
docker compose rm postgres-anonymiser --volumes
```

## II. Semi-automated

This is the currently implemented and tested solution.
It uses a docker container with a `postgres_anonymizer` instance already setup.

This works as follows:

1. Initialize the `postgres_anonymizer` database with the initial data.

   ```bash
   task up
   ```

2. Mount a couple of scripts to easily manipulate and export the new anonymized.

   ```bash
   task process
   ```

3. You can also revert the database to its initial state for debugging purposes

   ```bash
   task reset-db
   ```

## III. Automated method (WIP)

The above steps can be easily automated.
It uses a docker container that runs the same image under the hoods and operates directly on a `.sql` dump

See [the automation folder](./automation/README.md) for more details.

## Resources

- [PostgreSQL Anonymizer Documentation](https://postgresql-anonymizer.readthedocs.io/en/stable/)
- [PostgreSQL Anonymizer Repository](https://gitlab.com/dalibo/postgresql_anonymizer)
- [How to Anonymization and Data Masking for PostgreSQL in Ubuntu 22.04 LTS Server - 2023](https://youtu.be/niIIFL4s-L8)

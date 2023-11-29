#!/bin/bash

# Script Name: start.sh
# Description: This script is used to anonymise data in a PostgreSQL database using docker-compose.
#              It executes a series of SQL scripts inside the 'postgres-anonymiser' container.
#              Finally, it writes the anonymised database to a file in the 'out' directory.
#
# Usage:       Run this script from the directory where your docker-compose.yml file is located (or using the Taskfile).
#
# The script performs the following operations:
# 1. Runs a clean-up script to prepare the database for anonymisation.
# 2. Creates a function for generating unique fake emails.
# 3. Executes the anonymisation script to anonymise the data.
# 4. Outputs the anonymised database to a file in the 'out' directory.
#
# Note: The SQL scripts are mounted in the 'postgres-anonymiser' container under the '/scripts' directory.

docker exec postgres-anonymiser bash -c "psql -U ilg -d ilg -f /scripts/clean_up.sql"
docker exec postgres-anonymiser bash -c "psql -U ilg -d ilg -f /scripts/unique_fake_email.sql"
docker exec postgres-anonymiser bash -c "psql -U ilg -d ilg -f /scripts/anonymise.sql"
docker exec postgres-anonymiser bash -c "pg_dump -U ilg -d ilg -n public" >./out/ilg_anonymised.sql

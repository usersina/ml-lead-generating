#!/bin/bash

# Script Name: start.sh
# Description: This script is used to anonymise data in a PostgreSQL database using docker-compose.
#              It executes a series of SQL scripts inside the 'postgres-anonymiser' container.
# Usage:       Run this script from the directory where your docker-compose.yml file is located.
#
# The script performs the following operations:
# 1. Runs a clean-up script to prepare the database for anonymisation.
# 2. Creates a function for generating unique fake emails.
# 3. Executes the anonymisation script to anonymise the data.

# Note: The SQL scripts should be mounted in the 'postgres-anonymiser' container under the '/scripts' directory.

# Uncomment the following line to open a shell directly in the postgres-anonymiser container
# docker-compose exec postgres-anonymiser bash -c "psql -U ilg -d ilg"

# Run the clean-up script
docker exec postgres-anonymiser bash -c "psql -U ilg -d ilg -f /scripts/clean_up.sql"

# Create the function for getting a unique fake email
docker exec postgres-anonymiser bash -c "psql -U ilg -d ilg -f /scripts/unique_fake_email.sql"

# Run the anonymisation script
docker exec postgres-anonymiser bash -c "psql -U ilg -d ilg -f /scripts/anonymise.sql"

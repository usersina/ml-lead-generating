#!/bin/bash

# Script Name: export_to_csv.bash
# Description: This script is used to export data from a PostgreSQL database to CSV files.
#              The CSV files will be directly saved in the /out folder (which is mounted to the host machine).
#
# Usage:       Run this script with three arguments: user, database, and schema.
#              For example: ./export_to_csv.bash myuser mydatabase myschema

# Check if the correct number of arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Illegal number of parameters. You need to provide 3 parameters: user, database, and schema."
    exit 1
fi

USER=$1
DB=$2
SCHEMA=$3

psql -U $USER -Atc "select tablename from pg_tables where schemaname='$SCHEMA'" $DB |
    while read TBL; do
        echo "Exporting table: $SCHEMA.$TBL"
        psql -U $USER -c "COPY \"$TBL\" TO STDOUT WITH CSV HEADER" $DB >/out/$TBL.csv
    done

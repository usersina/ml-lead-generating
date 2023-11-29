# Automation (WIP)

Te process can be fully automated, eventually to be integrated in an MLOps workflow.

## 1. Defining the rules

- The rules should be defined in the same manner in a file.
  See [`anonymize.sql`](../scripts/anonymise.sql)

## 2. Running the script

- Run the script [`anon.sh`](./anon.sh)

This should now output a new `anon_dump.sql` to the same directory.

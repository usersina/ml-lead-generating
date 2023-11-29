#!/bin/bash

# NOTE: This script is not completed, it is just a draft.

rm -f ./out/anon_dump.sql

IMG=registry.gitlab.com/dalibo/postgresql_anonymizer:stable
ANON="docker run --rm -i $IMG /anon.sh"

# Missing the clean_up.sql script, might not work
cat ../init/ilg-data.sql ../scripts/anonymise.sql | $ANON >./out/anon_dump.sql

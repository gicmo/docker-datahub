#!/bin/bash

echo "-=[ creating datahub user & database ]=-"

if [ -z "$DATAHUB_PASSWORD" ]; then
  echo "WARN: DATAHUB_PASSWORD is empty!"
fi

gosu postgres postgres --single <<- EOSQL
   CREATE DATABASE datahub;
   CREATE USER datahub PASSWORD '$DATAHUB_PASSWORD' SUPERUSER CREATEROLE;
   GRANT ALL PRIVILEGES ON DATABASE datahub to datahub;
EOSQL

{ echo; echo "host all all 0.0.0.0/0 md5"; } >> "$PGDATA"/pg_hba.conf
echo "-=[ all done ]=-"

#!/usr/bin/env bash

flask db init
flask db migrate
flask db upgrade

export PGPASSWORD=$POSTGRES_PASSWORD;
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USERNAME" --dbname "$POSTGRES_DATABASE" <<-EOSQL
    INSERT INTO "public"."berat_badan" ("id", "max", "min", "perbedaan", "tanggal") VALUES
    (1, 50, 48, 2, '2018-08-18'),
    (2, 51, 50, 1, '2018-08-19'),
    (3, 52, 50, 2, '2018-08-20'),
    (4, 49, 49, 0, '2018-08-21'),
    (5, 50, 49, 1, '2018-08-22');
EOSQL

export FLASK_ENV=development
flask run -h 0.0.0.0

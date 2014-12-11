#!/usr/bin/bash

cd /srv/datahub

if [ "$DATAHUB_INITDB" ]; then
  echo "-=[ initializing db ]=-"
  python src/manage.py syncdb
  python src/manage.py migrate inventory
fi

echo "-=[ starting server ]=-"
python src/manage.py runserver 0.0.0.0:8000
docker-datahub
===============

Dockerfile for MIT's [Datahub](http://datahub.csail.mit.edu/www/)

Consists of two docker containers that are linked together:
  - A postgresql container that provides that database
  - The datahub container with the actual datahub service running

First build and start the psogres docker, see the README.md in the psql folder.
Then build and start this continer with:
```shell
docker build -t datahub .
docker run -p 8000:8000 -P --name datahub --link datahub_postgres:postgres -d datahub
#add "-e DATAHUB_INITDB=1" to initialize the DB on the first start
```

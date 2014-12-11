
Link datahub container with postgres container
docker build -t datahub .
docker run -p 8000:8000 -P --name datahub --link datahub_postgres:postgres -d datahub
Add "-e DATAHUB_INITDB=1" to initialize the DB
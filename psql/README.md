

usage
=====

```sh
docker build -t datahub_postgres .
docker run -d --name datahub_postgres -p 5432:5432  -e POSTGRES_PASSWORD=datahub -e DATAHUB_PASSWORD=datahub datahub_postgres
```

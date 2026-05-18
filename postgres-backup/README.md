# STACKIT-CLI

## set project-id as env variable
```bash
export STACKIT_PROJECT_ID=e83611ea-c0bc-48ad-986b-cb6798befa0d
```

## Seed the database with the alphabet (26 letters)
```bash
psql postgresql://abc_db_user:inVgBiCNG3Rw2HGQ1DGsckLNpuz05lzZeGxDZSAk0rQiA41NmUjIgOU1UJiOVRKX@b7c0b458-38ac-4ada-89a3-9ebcee206089.postgresql.eu01.onstackit.cloud:5432/abc-db -f seed-alphabet.sql
```

## Get Postgres Instance
```bash
stackit postgresflex instance list
```

## Get backups
```bash
stackit postgresflex backup list --instance-id b7c0b458-38ac-4ada-89a3-9ebcee206089
```

## Clone backup
https://docs.stackit.cloud/products/databases/postgresql-flex/how-tos/backup-and-clone-postgresql-flex/#prerequisites
```bash
stackit postgresflex instance clone b7c0b458-38ac-4ada-89a3-9ebcee206089 --recovery-timestamp 2026-05-14T12:04:04+00:00
```

## Connect to db
```bash
psql postgresql://abc_db_user:inVgBiCNG3Rw2HGQ1DGsckLNpuz05lzZeGxDZSAk0rQiA41NmUjIgOU1UJiOVRKX@b7c0b458-38ac-4ada-89a3-9ebcee206089.postgresql.eu01.onstackit.cloud:5432/abc-db
```


## Try to configure a hourly backup -> error
```bash
stackit postgresflex backup update-schedule --instance-id b7c0b458-38ac-4ada-89a3-9ebcee206089 --schedule "0 * * * *"
```
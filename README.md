# CATTE(D)RALL

ELT

## Setup

### Pré-requis

- Python
- uv
- Docker

### DBT

Ce projet utilise `uv` comme gestionnaire de dépendances Python. `dbt` est une bibliothèque Python utilisée pour la transformation des données. On utilise l'adaptateur Postgres.

Pour synchroniser les dépendances (e.g. installer `dbt-postgres`) :

```bash
uv sync
```

### Postgres et PGAdmin

Nous utilisons Postgres comme base de données. Pour démarrer le service en utilisant Docker Compose :

```bash
docker compose up -d
```

Le Docker Compose contient également un service `pgadmin` pour la gestion de la base de données accessible via `http://localhost:15433`.

## Initialisation

Déposer les fichiers `.csv` dans `./seeds`.

```sh
dbt deps
dbt init
```

Suivre les instructions de DBT :

```
Enter a number: 1
host (hostname for the instance): localhost
port [5432]: 15432
user (dev username): postgres
pass (dev password): password
dbname (default database that dbt will build objects in): db
schema (default schema that dbt will build objects in): public
threads (1 or more) [1]: 1
```

Vérifier avec `dbt debug` puis lancer `dbt seed` et patienter.

## Etapes

1. CSV -> /seeds
2. Database connection details: in ~/.dbt/profiles.yml
3. Run command: dbt build

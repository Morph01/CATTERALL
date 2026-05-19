# CATTE(D)RALL

ELT

## Setup

Ce projet utilise `uv` comme gestionnaire de dépendances Python. `dbt` est une bibliothèque Python utilisée pour la transformation des données. On utilise l'adaptateur Postgres.

Pour synchroniser les dépendances (e.g. installer `dbt-postgres`) :

```bash
uv sync
```

Nous utilisons Postgres comme base de données. Pour démarrer le service en utilisant Docker Compose :

```bash
docker compose up -d
```

Le Docker Compose contient également un service `pgadmin` pour la gestion de la base de données accessible via `http://localhost:15433`.

## Useful commands

```sh
dbt deps
dbt init
```

## Steps

1. CSV -> /seeds
2. Database connection details: in ~/.dbt/profiles.yml
3. Run command: dbt build

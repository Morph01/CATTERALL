# CATTE(D)RALL

ELT

## Setup

Ce projet utilise `uv` comme gestionnaire de dépendances Python. `dbt` est une bibliothèque Python utilisée pour la transformation des données. On utilise l'adaptateur Postgres.

Pour synchroniser les dépendances (e.g. installer `dbt-postgres`) :

```bash
uv sync
```

## Useful commands

```sh
dbt deps
dbt init
```

## Steps

1. CSV -> /seeds
2. Database connection details: in ~/.dbt/profiles.yml
3. Run command: dbt build

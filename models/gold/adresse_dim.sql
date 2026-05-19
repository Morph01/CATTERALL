SELECT DISTINCT ON (code_postal) a.code_postal as cp, d.departement_name as departement, d.region_name as region
FROM {{ ref('adhesion') }} a, {{ ref('departement') }} d
WHERE a.dep_int = d.departement_code
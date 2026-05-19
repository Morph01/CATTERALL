WITH D AS (
    SELECT * FROM {{ ref('Dept_region') }}
)

SELECT D."DEPARTMENTCODE" AS departement_code, D."DEPARTMENTNAME" AS departement_name, D."REGIONCODE" AS region_code, D."REGIONNAME" AS region_name
    FROM D

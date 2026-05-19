SELECT DISTINCT ON (acte)
    acte,
    designation_acte,
    categorie_acte
FROM {{ ref('prestations_sante') }}
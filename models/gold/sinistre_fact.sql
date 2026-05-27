WITH adhesion_dedup AS (
    SELECT DISTINCT ON (num_adhesion_normalise) *
    FROM {{ ref('adhesion') }}
    ORDER BY num_adhesion_normalise, annee_contrat
)

SELECT
    -- clés étrangères de dimensions
    ps.num_beneficiaire_sinistre AS beneficiaire_id,
    EXTRACT(years FROM justify_interval(AGE(ps.date_debut_soins, a.date_naissance_assure)))::integer AS age_id,
    ps.date_debut_soins AS date_soins_id,
    ps.date_paiement AS date_remboursement_id,
    ps.acte AS acte_id,
    a.num_contrat AS contrat_id,
    a.code_postal AS adresse_id,

    -- attributs du fait
    m.temperature_moyenne,
    (DATE_PART('year', ps.date_debut_soins) - a.annee_contrat)::integer AS anciennete,
    ps.frais_reel_assure,
    ps.montant_secu,
    ps.montant_rembourse
FROM
    {{ ref('prestations_sante') }} ps,
    adhesion_dedup a,
    {{ ref('meteo') }} m
WHERE
    ps.num_adhesion = a.num_adhesion_normalise
    AND a.departement = m.departement
    AND ps.date_debut_soins = m.date

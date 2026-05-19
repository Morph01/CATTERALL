WITH adhesion_dedup AS (
    SELECT DISTINCT ON (num_beneficiaire_unique) *
    FROM {{ ref('adhesion') }}
    ORDER BY num_beneficiaire_unique, annee_paiement
)

SELECT
    ps.num_beneficiaire_sinistre,
    a.code_postal,
    EXTRACT(years FROM justify_interval(AGE(ps.date_debut_soins, a.date_naissance_assure))),
    ps.date_debut_soins,
    m.temperature_moyenne,
    (DATE_PART('year', ps.date_debut_soins) - a.annee_paiement) AS anciennete,
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
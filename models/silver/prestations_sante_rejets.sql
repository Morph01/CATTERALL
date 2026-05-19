WITH source AS (
    -- même CTE source que ton modèle principal
    SELECT
        "NUM_SINISTRE"               AS num_sinistre,
        "NUM_ADHESION"               AS num_adhesion,
        "ACTE"                       AS acte,
        "DESIGNATION_ACTE"           AS designation_acte,
        "LIBELLE_BAREME"             AS libelle_bareme,
        "NUM_BENEFICIAIRE"           AS num_beneficiaire,
        "NUM_BENEFICIAIRE_SINISTRE"  AS num_beneficiaire_sinistre,
        "JOUR_DEBUT_SOINS"           AS jour_debut_soins,
        "MOIS_DEBUT_SOINS"           AS mois_debut_soins,
        "ANNEE_DEBUT_SOINS"          AS annee_debut_soins,
        "JOUR_PAIEMENT"              AS jour_paiement,
        "MOIS_PAIEMENT"              AS mois_paiement,
        "ANNEE_PAIEMENT"             AS annee_paiement,
        "FRAIS_REEL_ASSURE"          AS frais_reel_assure,
        "MONTANT_SECU"               AS montant_secu,
        "MONTANT_REMBOURSE"          AS montant_rembourse
    FROM {{ ref('Prestations_sante') }}
),

rejets AS (
    SELECT
        *,
        TRIM(CONCAT_WS(', ',
            CASE WHEN num_adhesion NOT IN (
                SELECT DISTINCT "NUM_ADHESION_NORMALISE" FROM {{ ref('Adhesion_detail') }}
            ) THEN 'adhesion_inconnue' END,

            CASE WHEN num_beneficiaire_sinistre NOT IN (
                SELECT DISTINCT "NUM_BENEFICIAIRE" FROM {{ ref('Beneficiaire') }}
            ) THEN 'beneficiaire_inconnu' END,

            CASE WHEN frais_reel_assure   < 0 THEN 'frais_reel_negatif'    END,
            CASE WHEN montant_secu        < 0 THEN 'montant_secu_negatif'  END,
            CASE WHEN montant_rembourse   < 0 THEN 'montant_rembourse_negatif' END
        )) AS motif_rejet,

        current_timestamp AS detected_at

    FROM source

    WHERE NOT EXISTS (
        SELECT 1 FROM {{ ref('Adhesion_detail') }} a
        WHERE a."NUM_ADHESION_NORMALISE" = source.num_adhesion
    )
    OR NOT EXISTS (
        SELECT 1 FROM {{ ref('Beneficiaire') }} b
        WHERE b."NUM_BENEFICIAIRE" = source.num_beneficiaire_sinistre
    )
    OR frais_reel_assure  < 0
    OR montant_secu       < 0
    OR montant_rembourse  < 0
)

SELECT * FROM rejets
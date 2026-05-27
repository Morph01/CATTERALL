WITH source as (
	SELECT "NUM_SINISTRE" as num_sinistre, 
    "NUM_ADHESION" as num_adhesion,
    "ACTE" as acte,
    "DESIGNATION_ACTE" as designation_acte,
    "LIBELLE_BAREME" as libelle_bareme,
    "NUM_BENEFICIAIRE" as num_beneficiaire,
    "NUM_BENEFICIAIRE_SINISTRE" as num_beneficiaire_sinistre,
    "JOUR_DEBUT_SOINS" as jour_debut_soins,
    "MOIS_DEBUT_SOINS" as mois_debut_soins,
    "ANNEE_DEBUT_SOINS" as annee_debut_soins,
    "JOUR_PAIEMENT" as jour_paiement,
    "MOIS_PAIEMENT" as mois_paiement,
    "ANNEE_PAIEMENT" as annee_paiement,
    "FRAIS_REEL_ASSURE" as frais_reel_assure,
    "MONTANT_SECU" as montant_secu,
    "MONTANT_REMBOURSE" as montant_rembourse
    FROM {{ ref('Prestations_sante') }}
),

normalized as (

	SELECT

	num_sinistre,
    num_adhesion,
    acte,
    designation_acte,
    {{ assurance.get_designation('designation_acte') }} as categorie_acte,
    libelle_bareme,
    num_beneficiaire,
    num_beneficiaire_sinistre,
    make_date(annee_debut_soins, mois_debut_soins, jour_debut_soins) as date_debut_soins,
    make_date(annee_paiement, mois_paiement, jour_paiement) as date_paiement,
    frais_reel_assure,
    montant_secu,
    montant_rembourse

	FROM source

    WHERE EXISTS (
        SELECT 1 FROM {{ ref('Adhesion_detail') }} a
        WHERE a."NUM_ADHESION_NORMALISE" = source.num_adhesion
    )
    AND EXISTS (
        SELECT 1 FROM {{ ref('Beneficiaire') }} b
        WHERE b."NUM_BENEFICIAIRE" = source.num_beneficiaire_sinistre
    )
    AND frais_reel_assure  >= 0
    AND montant_secu       >= 0
    AND montant_rembourse  >= 0
    AND frais_reel_assure  IS NOT NULL
    AND montant_secu       IS NOT NULL
    AND montant_rembourse  IS NOT NULL
)

select * from normalized
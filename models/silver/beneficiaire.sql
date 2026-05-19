WITH source as (
	SELECT "NUM_BENEFICIAIRE" as num_beneficiaire, "SEXE" as sexe, "REGIME_SOCIAL" as regime_social FROM {{ ref('Beneficiaire') }}
),

normalized as (

	SELECT

	num_beneficiaire,

	CASE LOWER(TRIM(sexe))
		WHEN 'm' THEN 'Homme'
		WHEN 'f' THEN 'Femme'
	END as sexe,

	CASE regime_social
		WHEN 'A' THEN 'Agricole'
		WHEN 'G' THEN 'Général'
		ELSE 'Spécial'
	END as regime_social

	FROM source
)

select * from normalized
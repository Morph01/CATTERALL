with source as (
   select "NUM_ADHESION_NORMALISE" as num_adhesion_normalise,
          "NUM_BENEFICIAIRE_UNIQUE" as num_beneficiaire_unique,
          "DATE_NAISSANCE_ASSURE" as date_naissance_assure,
          "CODE_POSTAL" as code_postal,
          "EXERCICE_PAIEMENT" as annee_paiement,
          "NUM_BENEFICIAIRE" as num_beneficiaire,
          "TYPE_BENEFICIAIRE" as type_beneficiaire,
          "DATE_NAISSANCE_BENEFICIAIRE" as date_naissance_beneficiaire,
          "CODE_PROFESSION" as code_profession,
          "CODE_PRODUIT" as code_produit,
          "CODE_FRACTIONNEMENT" as code_fractionnement,
          "CODE_GARANTIE" as code_garantie,
          "FORMULE" as formule,
          "PRIMES_ACQUISES" as primes_acquises,
          "CODE_AGENT" as code_agent,
          "CODE_REGION" as code_region,
          "PRIME_GARANTIE" as prime_garantie
     from
      {{
            ref('Adhesion_detail')
         }}
    where "CODE_POSTAL" <= 0 or "CODE_PROFESSION" not in (select "code" from {{ ref('classification') }})
)

select *
  from source
with source as (
   select "NUM_ADHESION_NORMALISE" as num_adhesion_normalise,
          "NUM_BENEFICIAIRE_UNIQUE" as num_beneficiaire_unique,
          "DATE_NAISSANCE_ASSURE" as date_naissance_assure,
          "CODE_POSTAL" as code_postal,
          "EXERCICE_PAIEMENT" as annee_contrat,
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
    where "CODE_POSTAL" > 0 AND "CODE_PROFESSION" in (select "code" from {{ ref('classification') }})
),

normalized as (
   select num_adhesion_normalise,
          num_beneficiaire_unique,
          num_adhesion_normalise::text || num_beneficiaire_unique::text || annee_contrat::text as num_contrat,
          TO_DATE(date_naissance_assure, 'DD/MM/YYYY') as date_naissance_assure,
          code_postal,
          LPAD(case
               when code_postal between 20000 and 20199 then '2A'
               when code_postal between 20200 and 20289 then '2B'
               when code_postal >= 20290 and code_postal < 21000 then '2B'
               when code_postal / 1000 > 96 then cast(code_postal / 1000 as text)
               else cast(code_postal / 1000 as text)
          end, 2, '0') as departement,
          case 
               when code_postal / 1000 > 96 then code_postal / 1000
               else code_postal / 1000
          end as dep_int,
          annee_contrat,
          num_beneficiaire,
          type_beneficiaire,
          TO_DATE(date_naissance_beneficiaire, 'DD/MM/YYYY') as date_naissance_beneficiaire,
          code_profession,
          code_produit,
          code_fractionnement,
          code_garantie,
          formule,
          SPLIT_PART(formule, ' ', 1) as categorie_formule,
          primes_acquises,
          code_agent,
          code_region,
          prime_garantie
     from source
)

select *
  from normalized
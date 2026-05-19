with source as (
    select "Niveau" as niveau,
           "Code" as "code",
           "Catégorie" as categorie,
           "Famille_métier" as famille_metier,
           "Intitulé" as intitule
      from
       {{
             ref('Classification_CCN_IDCC218')
          }}
)

select *
  from source
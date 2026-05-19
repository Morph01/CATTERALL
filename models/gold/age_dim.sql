WITH RECURSIVE seq AS (
    SELECT 0 AS age_id
        UNION ALL
    SELECT age_id+1 FROM seq WHERE age_id < 110
)

SELECT age_id,
CASE 
	WHEN age_id <= 2 THEN 'Nourisson'
	WHEN age_id <= 11 THEN 'Enfant'
	WHEN age_id <= 14 THEN 'Pré-adolescent'
	WHEN age_id <= 17 THEN 'Adolescent'
	WHEN age_id <= 25 THEN 'Jeune adulte'
	WHEN age_id <= 59 THEN 'Adulte'
	ELSE 'Senior'
END as groupe_age
  FROM seq

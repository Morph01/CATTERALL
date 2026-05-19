WITH date_series AS (
	SELECT generate_series(
		timestamp '2009-01-01',
		timestamp '2012-12-31',
		interval '1 day'
	)::date AS dates
),

normalized AS (
	SELECT
		dates AS date_id,
		EXTRACT(year FROM dates) AS annee,
		EXTRACT(month FROM dates)::numeric::integer / 4 + 1 AS trimestre,
		to_char(dates, 'TMMonth') AS mois,
		CASE EXTRACT(month FROM dates + interval '12 days')::numeric::integer / 4
			WHEN 0 THEN 'Hiver'
			WHEN 1 THEN 'Printemps'
			WHEN 2 THEN 'Été'
			WHEN 3 THEN 'Automne'
		END AS saison,
		EXTRACT(day FROM dates) AS num_jour_mois,
		to_char(dates, 'TMDay') AS jour
	FROM date_series
)

SELECT * from normalized
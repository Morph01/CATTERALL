SELECT
    date AS date,
    departement AS departement,
    round(tempmin::numeric, 2)::float AS temperature_min,
    round(tempmax::numeric, 2)::float AS temperature_max,
    round(ventmax::numeric, 2)::float AS vent_max,
    round(precip::numeric, 2)::float AS precipitation,
    CASE
        WHEN tempmin is not null AND tempmax is not null THEN round((tempmin::numeric + tempmax::numeric) / 2, 2)::float
        ELSE null
    END AS temperature_moyenne
        FROM {{ ref('MeteoByDep') }}

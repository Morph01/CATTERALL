{% macro sum_counts(table1, table2) %}

SELECT (SELECT COUNT(*) FROM {{ table1 }}) + (SELECT COUNT(*) FROM {{ table2 }}) AS somme

{% endmacro %}

{% macro test_count(tableBase, tableFiltered, tableReject) %}

WITH calcul AS 
(
	{{ sum_counts(tableFiltered, tableReject) }}
)

SELECT somme FROM calcul WHERE somme != (SELECT COUNT(*) FROM {{ tableBase }})

{% endmacro %}
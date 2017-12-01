SELECT
	SUM(table_size_MB)
FROM
	(
    SELECT
        segment_name table_name,
        SUM(bytes) / (1024 * 1024)
			table_size_MB
    FROM
        user_extents 
    WHERE
        segment_type = 'TABLE'
        AND segment_name LIKE '%'
    GROUP BY
        segment_name
    ORDER BY
        2 DESC
	)
;

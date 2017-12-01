-- Outputs the space currently occupied by the user's tables.
SELECT
	SUM(table_size_mb)
		AS "Size occupied by the user's tables (in MegaBytes)"
FROM
	(
		SELECT
			segment_name
				table_name,
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

-- Allows us to search though all tables available to us.
SELECT
	table_name
FROM
	all_tables
WHERE
	table_name LIKE '%PERSON%'
;

-- Allows us to look at a historic version of the table.
SELECT
	*
FROM
	${TABLE_NAME}
AS OF
	TIMESTAMP(SYSDATE() - 0.01)
;

-- List all tables in the user's schema.
SELECT DISTINCT
	object_name
FROM
	user_objects
WHERE
	object_type = 'TABLE'
;

SELECT
	tablespace_name,
	SUM(table_size_MB)
FROM
	(
	SELECT
		x.tablespace_name,
		segment_name
			table_name,
		SUM(bytes) / (1024 * 1024)
			table_size_MB
	FROM
		user_extents x
	WHERE
		segment_type = 'TABLE'
		AND segment_name LIKE '%'
	GROUP BY
		x.tablespace_name,
		segment_name
	ORDER BY
		2 DESC
	)
GROUP BY
	tablespace_name

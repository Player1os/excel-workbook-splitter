SELECT
	SUM(table_size_mb)
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

-- 
SELECT
	table_name
FROM
	all_tables
WHERE
	table_name LIKE '%PERSON%'
	AND table_name LIKE 'PDW%'
;

SELECT
	*
FROM
	max_support_table
AS OF
	timestamp(sysdate - 0.01)
;

-- List all tables in schema.
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
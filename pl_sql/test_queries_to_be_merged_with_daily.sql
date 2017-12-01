SELECT
	employees_user.employee_master_key,
	employees_user.employee_name,
	employees_supervisor.employee_master_key master_key,
	employees_supervisor.employee_name display_name
FROM
	tdw_employees employees_user,
	tdw_employees employees_supervisor,
	tdw_departments departments
WHERE
	employees_user.department_key = departments.department_key
	AND departments.r_sprvisor_employee_master_key = employees_supervisor.employee_master_key
	AND employees_user.lastflag = 'Y'
	AND employees_supervisor.lastflag = 'Y'
	AND NOT (employees_supervisor.employee_master_key = 0)
GROUP BY
	employees_user.employee_master_key,
	employees_user.employee_name,
	employees_supervisor.employee_master_key,
	employees_supervisor.employee_name
;

SELECT
	employee_name
FROM
	tdw_employees,
	tdw_departments
WHERE
	tdw_employees.department_key = tdw_departments.department_key
	AND NOT (tdw_departments.r_sprvisor_employee_master_key = 0)
;

SELECT
	count(count(*))
FROM
	max.max_support_table1 m,
	dimagadal.voice_partner_agr_201603_v3 l
WHERE
	m.comp_reg_no = l.ico
GROUP BY
	l.ico
;

SELECT
	m.hierarchy_depth,
	m.comp_reg_no,
	count(*)
FROM
	max.max_support_table1 m,
	dimagadal.voice_partner_agr_201603_v3 l
WHERE
	m.comp_reg_no = l.ico
GROUP BY
	m.comp_reg_no
;

SELECT
	*
FROM
	etdw.pdw_account_visibility e
WHERE
	comp_reg_no = '50021150'
;

SELECT DISTINCT
	sbl.customer_id,
	sbl.customer_name,
	sbl.comp_reg_no,
	sbl.customer_type
		AS segment,
	sbl.microsegment,
	sbl.primary_flag,
	sbl.account_group,
	sbl.pccp1,
	sbl.pccp1_name,
	sbl.pccp2,
	sbl.pccp2_name,
	sbl.psp,
	sbl.psp_name,
	sbl.psp_account_position_name,
	pll.sbl_parent_person_unified_id
		AS sbl_supervizor_id,
	pll1.person_last_name || ' ' || pll1.person_first_name
		AS sbl_supervizor_name,
	pll1.sbl_parent_person_unified_id
		AS sbl_manager_id,
	pll2.person_last_name || ' ' || pll2.person_first_name
		AS sbl_manager_name
FROM
	etdw.exf_ngcrm2appint_customer_ng sbl
	LEFT JOIN etdw.exd_person_list pll
		ON sbl.psp = pll.person_unified_id
	LEFT JOIN etdw.exd_person_list pll1
		ON pll.sbl_parent_person_unified_id = pll1.person_unified_id
	LEFT JOIN etdw.exd_person_list pll2
		ON PLL1.sbl_parent_person_unified_id = pll2.person_unified_id
WHERE
   sbl.customer_type IN ('SME', 'LA','TA','WS A','WS B')
   AND
   sbl.customer_status <> 'Terminated'
   AND
   sbl.account_class = 'Customer'
   AND
   sbl.account_type = 'Business'
;

SELECT
	employee_master_key,
	comp_reg_no
FROM
	max.max_support_table1
WHERE
	employee_master_key = 588944777
GROUP BY
	employee_master_key,
	comp_reg_no
ORDER BY
	count(*) DESC
;

SELECT
	count(count(*))
FROM
	max.max_support_table1 m,
	dimagadal.voice_partner_agr_201603_v3 l,
	tdw_employees e,
	tdw_departments d
WHERE
	e.department_key = d.department_key
	AND NOT (d.r_sprvisor_employee_master_key = 0)
	AND e.employee_master_key = m.employee_master_key
	AND m.comp_reg_no = l.ico
GROUP BY
	m.employee_master_key,
	l.ico
;

SELECT
	count(count(*))
FROM
	max.max_support_table1 m,
	dimagadal.voice_partner_agr_201603_v3 l
WHERE
	m.comp_reg_no = l.ico
GROUP BY
	m.employee_master_key, l.ico
;

SELECT
	count(*)
FROM
	(
	SELECT DISTINCT
		ico
	FROM
		dimagadal.voice_partner_agr_201603_v3
	) a,
	(
	SELECT DISTINCT
		sbl.comp_reg_no AS account_ico,
		pll_lvl1.person_unified_id AS employee_id,
		pll_lvl1.person_first_name AS employee_first_name,
		pll_lvl1.person_last_name AS employee_last_name,
		pll_lvl2.person_unified_id AS supervisor_id,
		pll_lvl2.person_first_name AS supervisor_first_name,
		pll_lvl2.person_last_name AS supervisor_last_name
	FROM
		etdw.exf_ngcrm2appint_customer_ng sbl
		LEFT JOIN
		etdw.exd_person_list pll_lvl1
			ON sbl.psp = pll_lvl1.person_unified_id
			LEFT JOIN etdw.exd_person_list pll_lvl2
				ON pll_lvl1.sbl_parent_person_unified_id = pll_lvl2.person_unified_id
	WHERE
		sbl.customer_status <> 'Terminated'
		AND	 sbl.account_class = 'Customer'
		AND	 sbl.account_type = 'Business'
	) b
WHERE
	a.ico = b.account_ico
;

SELECT 
	acc.segment_name
		AS act_segment,
	asa.source_code
		AS account_status,
	acc.comp_reg_no,
	acc.account_key,
	acc.account_id,
	acc.siebel_source_id,
	ss.country,
	ss.town,
	ss.county,
	ROW_NUMBER()
		OVER
		(
		PARTITION BY
			acc.comp_reg_no
		ORDER BY
			DECODE (ss.country, 'Slovakia (Slovak Republic)', '1', 'Slovensko', 1, 2 ),
			acc.group_key desc
		) rn,
	acc.name company_name,
	CASE WHEN
		(
			acc.name LIKE '%konkurze%'
			OR
			acc.name LIKE '%likvid %'
		)
		THEN
			'Y'
		ELSE
			'N'
		END
			"KONKURZ/LIKVIDACE",
	acc.on_blacklist_flag,
	acc.total_debt_amount,
	acc.group_name
		AS account_group,
	acc.group_key,
	acc.employee_psp_key,
	ea.employee_name employee_psp_name,
	e2.employee_name
		AS supervisor_employee_name,
	e3.employee_name
		AS manager_employee_name 
FROM 
	pdw_accounts acc,
	pdw_employee_all ea,
	tdw_employees e1, 
	tdw_employees e2, 
	tdw_employees e3,
	tdw_departments dd,
	pdw_address_points ss,
	tdw_account_status_all asa
WHERE
	ea.employee_key = acc.employee_psp_key
	AND ea.employee_master_key =  e1.employee_master_key 
	AND e1.department_key = dd.department_key
	AND dd.r_sprvisor_employee_master_key = e2.employee_master_key
	AND dd.tmsk_mng_employee_master_key = e3.employee_master_key
	AND acc.address_point_key = ss.address_point_key
	AND ACC.business_primary_record_flag = 'Y'
	AND acc.account_class = 'Customer'
	AND acc.segment_name IN ('SME','LA','TA','VSE/SOHO') 
	AND e1.lastflag = 'Y'
	AND e2.lastflag = 'Y'
	AND e3.lastflag = 'Y'
	AND acc.account_status_key = asa.account_status_key
	AND asa.account_status_key <> 4 --Terminated
GROUP BY
	acc.segment_name,
	asa.source_code,
	acc.comp_reg_no,
	acc.account_key,
	acc.account_id,
	acc.siebel_source_id,
	ss.country,
	ss.town,
	ss.county,
	acc.name,
	CASE WHEN (
		acc.name LIKE '%konkurze%'
		OR acc.name LIKE '%likvid %'
	) THEN
		'Y'
	ELSE
		'N'
	END,
	acc.on_blacklist_flag,
	acc.total_debt_amount,
	acc.group_name,
	acc.group_key,
	acc.employee_psp_key,
	ea.employee_name,
	e2.employee_name,
	e3.employee_name
ORDER BY
	rn,
	country

;
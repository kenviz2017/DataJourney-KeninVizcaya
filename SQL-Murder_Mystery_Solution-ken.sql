
-- Determinar el reporte del asesinato
SELECT *
FROM crime_scene_report
WHERE date = '2018-01-15'
AND type = 'murder' AND city = 'SQL City';

-- Con la información del reporte buscamos los dos testigos

SELECT *
FROM person
WHERE address_street_name ='Franklin Ave' 
	AND name LIKE 'Annabel%'
		OR address_street_name = 'Northwestern Dr' 
	AND address_number = (SELECT MAX(address_number) 
							FROM person WHERE 
							address_street_name = 'Northwestern Dr');

-- Una vez identificados los testigos buscamos la información que dieron a la policia
SELECT *
FROM interview
WHERE person_id IN(16371, 14887);

--Buscamos al sospechoso segun los datos dados por los testigos

SELECT *
FROM drivers_license
WHERE plate_number LIKE '%H42W%';

SELECT *
FROM get_fit_now_member
WHERE membership_status = 'gold'
AND id LIKE '%48Z%';

--Corroboramos que toda la informacion dada por los testigos cuadre con el sospechoso

SELECT	p.id,
		p.name,
		d.plate_number,
		g.id AS membership_id,
		g.membership_status,
		p.ssn
FROM drivers_license AS d
INNER JOIN person AS p
ON d.id = p.license_id
INNER JOIN get_fit_now_member AS g
ON p.id = g.person_id
WHERE plate_number LIKE '%H42W%';

--Jeremy Bowers

SELECT *
FROM interview
WHERE person_id =67318;
-- El asesino nos da información clave para buscar al asesino intelectual

WITH cte AS (SELECT	p.id,
		p.name,
		d.plate_number,
		g.id AS membership_id,
		g.membership_status,
		p.ssn
FROM drivers_license AS d
INNER JOIN person AS p
ON d.id = p.license_id
INNER JOIN get_fit_now_member AS g
ON p.id = g.person_id
WHERE plate_number LIKE '%H42W%')

SELECT	cte.*,
		fb.event_id,
		fb.event_name,
		fb.date AS event_date,
		get_check.check_in_date AS anna_saw_date,
		get_check.check_in_time AS anna_saw_time_in,
		get_check.check_out_time AS anna_saw_time_out
FROM cte
INNER JOIN facebook_event_checkin AS fb
ON fb.person_id = cte.id
INNER JOIN get_fit_now_check_in AS get_check
ON get_check.membership_id = cte.membership_id
WHERE fb.event_id = 4719;

WITH female_suspect AS ( 
	SELECT	d.gender,
			d.height,
			d.hair_color,
			d.car_make,
			d.car_model,
			p.id,
			p.name,
			p.ssn,
			income.annual_income
	FROM drivers_license AS d
	INNER JOIN person AS p
	ON d.id = p.license_id
	INNER JOIN income
	ON p.ssn = income.ssn
	WHERE gender = 'female' AND hair_color = 'red'
	AND car_make = 'Tesla')
	
SELECT	female_suspect.*,
		fb.event_name,
		fb.date
FROM facebook_event_checkin AS fb
INNER JOIN female_suspect
ON female_suspect.id = fb.person_id
;

--Miranda Priestly

INSERT INTO solution VALUES (1, 'Miranda Priestly');

SELECT VALUE
FROM solution;



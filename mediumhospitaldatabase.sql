--1.Show unique birth years from patients and order them by ascending.
SELECT DISTINCT YEAR(birth_date) as birth_year
FROM patients
ORDER by birth_year asc;

--2.Show unique first names from the patients table which only occurs once in the list.
SELECT distinct first_name 
FROM patients
GROUP BY first_name
HAVING COUNT(first_name)=1;

--3.Show patient_id and first_name from patients where their first_name start and ends with 's' 
--and is at least 6 characters long.
SELECT patient_id,first_name
FROM patients
where first_name like 'S%' and first_name like '%S'
and length(first_name)>=6;

--4.Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
SELECT p.patient_id,p.first_name,p.last_name
FROM patients p
JOIN admissions a ON p.patient_id=a.patient_id
where a.diagnosis='Dementia';

--5.Display every patient's first_name.Order the list by
--the length of each name and then by alphabetically.
SELECT first_name
FROM patients
ORDER BY LENGTH(first_name),first_name ASC;

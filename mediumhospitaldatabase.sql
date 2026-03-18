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

--6.Show the total amount of male patients and total amount of female patients in patients table.
--Display the two results in same row.
SELECT COUNT(*) FILTER (WHERE gender='M') AS male_count,
COUNT(*) FILTER (WHERE gender='F') AS female_count
FROM patients;

--7.Show first and last name,allergies from patients which have allergies to either 'Penicillin' or 'Morphine'.Show results ordered ascending by allergies then by first_name then by last_name.
SELECT first_name,last_name,allergies
FROM patients
WHERE allergies IN ('Penicillin','Morphine')
ORDER BY allergies,first_name,last_name ASC;

--8.Show patient_id,diagnosis from admissions.Find patients admitted multiple times for the same diagnosis.
SELECT patient_id,diagnosis
FROM admissions
GROUP BY patient_id,diagnosis
HAVING COUNT(*)>1;


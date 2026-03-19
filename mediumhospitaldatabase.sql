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

--9.Show the city and the total number of patients in the city.Order from
--most to least patients and then by city name ascending.
SELECT city,COUNT(patient_id) AS num_patients
FROM patients
GROUP BY city
ORDER BY num_patients DESC,city ASC;

--10.Show first_name,last_name and role of every person that is 
--either patient or doctor. The roles are either "Patient" or "Doctor".
SELECT first_name,last_name,'Patient' AS Role
FROM patients
UNION ALL
SELECT first_name,last_name,'Doctor' AS Role 
FROM doctors;

--11.Show all allergies ordered by popularity.Remove NULL values 
--from query.
SELECT allergies, COUNT(allergies) AS total_diagnosis
FROM patients
WHERE allergies IS NOT NULL
GROUP BY allergies
ORDER BY total_diagnosis DESC;

--12.Show all patient's first_name,last_name and birth_date who were born in the 1970s 
--decade.Sort the list starting from the earliest birth_date.
SELECT first_name,last_name,birth_date 
FROM patients
WHERE birth_date BETWEEN '1970-01-01' AND '1979-12-30'
ORDER BY birth_date ASC;

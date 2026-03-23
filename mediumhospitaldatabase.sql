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

/*13. We want to display each patient's full name in a single column.
Their last_name in all upper letters must appear first,then first_name
in all lower case letters.Separate the last_name and first_name with a 
comma.Order the list by the first_name in descending order. */
SELECT UPPER(last_name)||','|| LOWER(first_name) AS new_name_format
FROM patients
ORDER BY first_name DESC;


--14.Show the province_id(s), sum of height,where the total sum of its
--patient's height is greater than or equal to 7000.
SELECT province_id, SUM(height) AS sum_height
FROM patients
GROUP BY province_id
HAVING sum_height>=7000;

--15.Show the difference between the largest weight and smallest weight
---for patients with the last name 'Maroni'.
  SELECT MAX(weight) -MIN(weight) AS weight_delta
  FROM patients
  WHERE last_name='Maroni';

--16. Show all of the days of month(1-31) and how many admission_dates
--occured on that day. Sort by day with most admissions to least admissions.
  SELECT DAY(admission_date) AS day_number,COUNT(patient_id) AS number_of_admissions
  FROM admissions
  GROUP BY DAY(admission_date)
  ORDER BY number_of_admissions DESC;

--17.Show all columns for patient_id 542's most recent admission_date.
SELECT *FROM admissions
WHERE patient_id=542
GROUP  BY patient_id
HAVING admission_date=MAX(admission_date);

/*18.Show patient_id,attending_doctor_id,and diagnosis for admissions 
that match one of the two criteria:
1. patient_id is an odd number and attending_doctor_id is either 1,5
or 19.
2.attending_doctor_id contains a 2 and the length of patient_id is 3 
characters. */
SELECT patient_id,attending_doctor_id,diagnosis
FROM admissions
WHERE (patient_id %2 <> 0 AND attending_doctor_id IN (1,5,19)) OR
(attending_doctor_id LIKE '%2%' AND LENGTH(patient_id)=3);

/*19. Show first_name,last_name,and total number of admissions attended
for each doctor. Every admission has been attended by a doctor. */
SELECT d.first_name,d.last_name,COUNT(a.attending_doctor_id) AS total_admissions
FROM doctors d
JOIN admissions a ON d.doctor_id=a.attending_doctor_id
GROUP BY d.first_name;

/*20. For each doctor,display their id,full name,and the first and 
last admission date they attended. */
SELECT d.doctor_id,d.first_name||' '|| d.last_name AS doctor_name,
  MAX(a.admission_date) AS first_admission,
MIN(a.admission_date) AS last_admission
FROM doctors d
JOIN admissions a ON d.doctor_id=a.attending_doctor_id
GROUP BY d.doctor_id
ORDER BY d.doctor_id DESC;

/*21. Display the total amount of patients for each province. Order by 
descending. */
SELECT pr.province_name,COUNT(p.patient_id) AS patient_count
FROM patients p
JOIN province_names pr ON p.province_id=pr.province_id
GROUP BY pr.province_name
ORDER BY patient_count DESC;

/*22. For every admission,display the patient's full name, their admission
diagnosis, and their doctor's full name who diagnosed their problem. */
SELECT p.first_name||' '|| p.last_name AS patient_name,a.diagnosis,
  d.first_name||' '|| d.last_name AS doctor_name
FROM patients p
JOIN admissions a ON p.patient_id=a.patient_id
JOIN doctors d ON a.attending_doctor_id=d.doctor_id;

/*23. Display the first name,last name and number of duplicate patients
based on their first name and last name. */
SELECT first_name,last_name,COUNT(*) AS num_of_duplicates
FROM patients
GROUP BY first_name,last_name
HAVING COUNT(*) >1;

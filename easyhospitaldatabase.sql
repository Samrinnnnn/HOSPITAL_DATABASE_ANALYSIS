--1.Show first name, last name, and gender of patients whose gender is 'M'
SELECT first_name,last_name,gender from patients
where gender='M';

--2.Show first name and last name of patients who does not have allergies. (null)
SELECT first_name,last_name from patients
where allergies IS NULL;

--3.Show first name of patients that start with the letter 'C'
SELECT first_name from patients
where first_name like 'C%';

--4.Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
SELECT first_name,last_name from patients
where weight  BETWEEN 100 AND 120;

--5.Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'
UPDATE patients SET allergies= 'NKA'
where allergies IS null;

--6.Show first name and last name concatinated into one column to show their full name.
SELECT first_name|| ' ' || last_name as full_name
from patients;

--7.Show first name, last name, and the full province name of each patient.
SELECT p.first_name,p.last_name,pr.province_name
FROM patients p
JOIN province_names pr ON p.province_id=pr.province_id;

--8.Show how many patients have a birth_date with 2010 as the birth year.
SELECT COUNT(patient_id) as total_patients
FROM patients 
where 
yEAR(birth_date)=2010;

--9.Show the first_name, last_name, and height of the patient with the greatest height.
SELECT first_name,last_name,MAX(height) as greatest_height 
from patients;

--10.Show all columns for patients who have one of the following patient_ids:1,45,534,879,1000
SELECT *from patients 
where patient_id IN (1,45,534,879,1000);

--11.Show the total number of admissions
SELECT COUNT(patient_id) as total_admissions
from admissions;

--12.Show all the columns from admissions where the patient was admitted and discharged on the same day.
SELECT *FROM admissions
where admission_date=discharge_date;

--13.Show the patient id and the total number of admissions for patient_id 579.
SELECT patient_id,COUNT(patient_id) as total_admissions
from admissions
where patient_id=579;

--14.Based on the cities that our patients live in, show unique cities that are in province_id 'NS'.
Select DISTINCT city as unique_cities
from patients
where province_id='NS';

--15.Write a query to find the first_name, last name and birth date of patients who has height greater than 160 and weight greater than 70
Select first_name,last_name,birth_date
FROM patients
WHERE height>160 and weight>70;

--16.Write a query to find list of patients first_name, last_name, and allergies where allergies are not null and are from the city of 'Hamilton'
SELECT first_name,last_name,allergies
FROM patients
where allergies IS NOT NULL
AND CITY='Hamilton';

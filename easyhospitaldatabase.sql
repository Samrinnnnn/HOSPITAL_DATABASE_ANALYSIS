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

/* 1. Show all of the patients grouped into weight groups.Show
the total amount of patients in each weight group. Order the list by
the weight group decending. For example, if they weight 
100 to 109 they are placed in the 100 weight group,110-119=110 weight group,etc */
SELECT COUNT(patient_id) AS patients_in_group,weight-weight % 10 AS weight_group
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC;

/*2.Show patient_id,weight,height,isObese from patients table.Display
isObese as a boolean 0 or 1. Obese is defined as weight(kg)/height(m)2) >= 30.
weight is in units kg, height in units cm. */
SELECT patient_id,weight,height,
CASE WHEN (weight/POWER(height,2)/10000.0))>=30 THEN '1'
ELSE '0'
END AS isObese
FROM patients
GROUP BY patient_id;

/*3. Show patient_id,first_name,last_name and attending doctor's specialty.Show only 
the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'
Check patients,admissions, and doctors tables for required information. */
SELECT p.patient_id,p.first_name,p.last_name,d.specialty
FROM patients p
JOIN admissions a ON p.patient_id=a.patient_id
JOIN doctors d ON a.attending_doctor_id=d.doctor_id
WHERE a.diagnosis='Epilepsy' AND d.first_name='Lisa'
GROUP BY p.patient_id;

/*4. All patients who have gone through admissions,can see their medical
documents on our site.Those patients are given a temporary password after 
their first admission.Show the patient_id and temp_password.
The password must be the following in order:
1. patient_id
2. the numerical length of patient's last_name
3. year of patient's birth_date*/
SELECT DISTINCT a.patient_id,ROUND(p.patient_id||LENGTH(p.last_name)
  || YEAR(p.birth_date),1)
AS temp_password
FROM patients p
JOIN admissions a ON p.patient_id=a.patient_id;

/*5 Each admission costs $50 for patients without insurance,and $10
for patients with insurance. All patients with an even patient_id
have insurance.Give each patient a 'Yes' if they have insurance,
and a 'No' if they don't have insurance.Add up the admission_total
cost for each has_insurance group. */
WITH admission_case AS
(
  SELECT CASE WHEN patient_id % 2 =0
  THEN 'Yes'
  ELSE 'No'
  END AS has_insurance
  FROM admissions
  )
SELECT has_insurance,CASE WHEN has_insurance='Yes'
THEN SUM(10)
ELSE SUM(50)
END AS cost_after_insurance
FROM admission_case
GROUP BY has_insurance;

/*6 Show the provinces that has more patients identified as 'M' than'F'.
Must only show full province_name. */
SELECT p.province_name
FROM province_names p
JOIN patients pa ON p.province_id=pa.province_id
GROUP BY p.province_name
HAVING SUM(gender='M') > SUM(gender='F');

/*7 We are looking for a specific patient. Pull all columns for the
patient who matches the following criteria:
First_name contains an 'r' after the first two letters.
Identifies their gender as 'F'
Born in Feb,May or Dec
Weight would be between 60 kg and 80 kg
patient_id is odd number
city'Kingston' */
SELECT *FROM patients WHERE gender='F' AND MONTH(birth_date) IN (2,5,12)
AND weight BETWEEN 60 AND 80 AND 
patient_id % 2=1 AND
city='Kingston';

/* 8 Show the percent of patients that have 'M' as their gender.Round 
the answer to the nearest hundreth number and in percent form. */
SELECT ROUND(100*AVG(gender='M'),2) || '%'  AS percent_of_male_patients 
FROM patients;

/*9. For each day display the total amount of admissions on that day.
Display the amount changed from the previous date. */
WITH admissions_daily AS
( SELECT admission_date,COUNT(patient_id) AS admission_day
  FROM admissions
  GROUP BY admission_date
  )
SELECT admission_date,admission_day,admission_day-LAG(admission_day)
OVER (ORDER BY admission_date) AS admission_count_change
FROM admissions_daily;

/*10. Sort the province names in ascending order in such a way that the province
'Ontario' is always on top. */
SELECT province_name
FROM province_names
ORDER BY(CASE WHEN province_name='Ontario' THEN 0
  ELSE 1
  END),
province_name;

/*11 . We need a breakdown for the total amount of admissions each doctor
has started each year. Show the doctor_id,doctor_full_name,specialty,year,
total_admissions for that year. */
SELECT d.doctor_id,d.first_name||' '||d.last_name AS doctor_name,d.specialty,
  YEAR(a.admission_date) AS selected_year,
COUNT(a.patient_id) AS total_admissions
FROM admissions a
LEFT JOIN doctors d ON a.attending_doctor_id=d.doctor_id
GROUP BY d.doctor_id,selected_year
ORDER BY d.doctor_id ASC;

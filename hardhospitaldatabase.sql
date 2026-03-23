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


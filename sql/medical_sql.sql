create database medical_data ;
use medical_data ;
--- # 1. Show first name, last name, and gender of patients whose gender is 'M'
SELECT * FROM patients;
SELECT first_name, last_name, gender
FROM patients
WHERE gender='M';

---  # 2.  Show first name and last name of patients who does not have allergies.
SELECT first_name, last_name 
FROM patients 
WHERE allergies is null;

--- # 3. Show first name of patients that start with the letter 'C'
SELECT * 
FROM patients 
WHERE first_name LIKE 'C%';

--- # 4. Show first name and last name of patients that weight within the range of 100 to 120 (inclusive).
SELECT first_name, last_name, weight
FROM patients
WHERE weight BETWEEN 100 AND 120;

--- #Q.5. Update the patients table for the allergy’s column. If the patient's allergies is null then replace it with 'NKA'
SELECT * ,
  CASE WHEN allergies IS NULL THEN "Nka"
  ELSE allergies
  END AS allergies
FROM patients;

--- #Q.6. Show first name and last name concatenated into one column to show their full name.
SELECT * 
FROM admissions;
SELECT concat (first_name,' ', last_name) AS full_name 
FROM patients;

--- #Q.7. Show first name, last name, and the full province name of each patient.
SELECT p.first_name, p.last_name, p1.province_name
FROM patients p 
left join province_names p1
on p.province_id = p1.province_id ;

--- #Q.8. Show how many patients have a birth_date with 2010 as the birth year.
SELECT COUNT(*) AS birth_date
FROM patients
WHERE year(birth_date) =2010;

--- #Q.9. Show the first_name, last_name, and height of the patient with the greatest height.
SELECT first_name, last_name, height
FROM patients
ORDER BY height DESC;

--- #Q.10. Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000
SELECT * 
FROM patients 
WHERE patient_id IN (1, 45, 534, 879, 1000);

--- #Q.11. Show the total number of admissions.
SELECT COUNT(*) AS total_admissions 
FROM admissions;

--- #Q.12. Show all the columns from admissions where the patient was admitted and discharged on the same day.
SELECT * 
FROM admissions 
WHERE admission_date= discharge_date;

--- #Q.13. Show the total number of admissions for patient_id 579.
SELECT COUNT(*) AS total_numbers
FROM admissions 
WHERE patient_id= 579;

--- #Q.14. Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?
SELECT DISTINCT (p.city), p1.province_name, p1.province_id 
FROM patients p
join province_names p1
on p.province_id = p1.province_id
where p1.province_id ="NS" ;

--- #Q.15. Write a query to find the first_name, last name and birth date of patients who have height more than 160 and weight more than 70?
SELECT first_name, last_name, birth_date
FROM patients
WHERE height>=160 AND weight>=70;  

--- #Q.16. Show unique birth years from patients and order them by ascending.
SELECT DISTINCT year(birth_date) AS birth_year 
FROM patients
ORDER BY birth_year ASC;

--- #Q.17. Show unique first names from the patients table which only occurs once in the list.
SELECT first_name
FROM patients
GROUP BY first_name
HAVING COUNT(*) = 1 ;

--- # Q.18. Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.
SELECT first_name, patient_id 
FROM patients 
WHERE first_name LIKE 'S%s' AND length(first_name) =6;

--- #Q.19. Show patient_id, first_name, last_name from patients whose diagnosis is 'Dementia'.   Primary diagnosis is stored in the admissions table. 
SELECT p.first_name, p.last_name, p.patient_id, a.diagnosis
FROM patients p
JOIN admissions a
ON p.patient_id =a.patient_id
WHERE a.diagnosis='Dementia';

--- #Q.20. Display every patient's first_name. Order the list by the length of each name and then by alphabetically.
SELECT first_name 
FROM patients
ORDER BY length(first_name) ASC, first_name ASC;

--- # Q.21. Show the total amount of male patients and the total amount of female patients in the patient table. Display the two results in the same row.
SELECT gender, COUNT(*)
FROM patients
GROUP BY gender;

--- # Q.22. Show the total amount of male patients and the total amount of female patients in the patient table. Display the two results in the same row.
SELECT gender, COUNT(*) 
FROM patients 
GROUP BY gender;

--- # Q.23. Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
SELECT p.patient_id, a.diagnosis 
FROM patients p
JOIN admissions a
ON p.patient_id = a.patient_id
GROUP BY patient_id, diagnosis
HAVING COUNT(*)>1;

--- #Q.24. Show the city and the total number of patients in the city. Order from most to least patients and then by city name ascending.

SELECT city, COUNT(*) 
FROM patients
GROUP BY city 
ORDER BY COUNt(*) DESC, city ASC;

--- #Q.25. Show first name, last name and role of every person that is either patient or doctor.    The roles are either "Patient" or "Doctor".
SELECT first_name, last_name, 'Patient' AS role
FROM patients
UNION
SELECT first_name, last_name, 'Doctor' AS role 
FROM doctors;

--- # Q.26. Show all allergies ordered by popularity. Remove NULL values from query.
SELECT COUNT(*), diagnosis 
FROM admissions 
WHERE diagnosis IS NOT NULL
GROUP BY diagnosis 
ORDER BY COUNT(*) DESC;

--- # Q.27. Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.
SELECT first_name, last_name, birth_date
FROM patients
WHERE birth_date BETWEEN '1970-01-01' AND '1979-12-31'
ORDER BY birth_date ASC;

--- # Q.28. We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lowercase letters. Separate the last_name and first_name with a comma. Order the list by the first_name in descending order    EX: SMITH, jane
SELECT concat(upper(last_name), ',', lower(first_name)) AS full_name FROM patients 
ORDER BY first_name DESC; 

--- # Q.29. Show the province_id (s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.
SELECT province_id, SUM(height) AS total_height
FROM patients
GROUP BY province_id
HAVING SUM(height) >= 7000;

--- #Q.30. Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni’.
SELECT (MAX(weight) - MIN(weight)) AS difference
FROM patients
WHERE last_name='Maroni';

--- #Q.31. Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.
SELECT DAY(admission_date) AS day_of_month, COUNT(*) AS total_admissions
FROM admissions
GROUP BY DAY(admission_date)
ORDER BY total_admissions DESC;

--- # Q.32. Show all of the patients grouped into weight groups. Show the total amount of patients in each weight group. Order the list by the weight group descending. e.g. if they weight 100 to109 they are placed in the 100-weight group, 110-119 = 110 weight group, etc.
SELECT
    CASE
        WHEN weight BETWEEN 0 AND 9 THEN 0
        WHEN weight BETWEEN 10 AND 19 THEN 10
        WHEN weight BETWEEN 20 AND 29 THEN 20
        WHEN weight BETWEEN 30 AND 39 THEN 30
        WHEN weight BETWEEN 40 AND 49 THEN 40
        WHEN weight BETWEEN 50 AND 59 THEN 50
        WHEN weight BETWEEN 60 AND 69 THEN 60
        WHEN weight BETWEEN 70 AND 79 THEN 70
        WHEN weight BETWEEN 80 AND 89 THEN 80
        WHEN weight BETWEEN 90 AND 99 THEN 90
        WHEN weight BETWEEN 100 AND 109 THEN 100
        WHEN weight BETWEEN 110 AND 119 THEN 110
        WHEN weight BETWEEN 120 AND 129 THEN 120
        WHEN weight BETWEEN 130 AND 139 THEN 130
        WHEN weight BETWEEN 140 AND 149 THEN 140
        WHEN weight BETWEEN 150 AND 159 THEN 150
    END AS weight_group,
    COUNT(DISTINCT patient_id) AS total_patients
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC;

--- #Q.33. Show patient_id, weight, height, is Obese from the patient table. Display is Obese as a Boolean  0 or 1. Obese is defined as weight(kg)/(height(m). Weight is in units kg. Height is in units cm.
SELECT patient_id, weight, height,
     CASE
	 WHEN weight / power(height/100.0, 2)>=30 THEN 1
	 ELSE 0
	 END AS obese
FROM patients;

--- # Q.34. Show patient_id, first_name, last_name, and attending doctor's specialty. Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'. Check patients, admissions, and doctors tables for required information.
SELECT p.patient_id, p.first_name, p.last_name, d.specialty 
FROM patients p
JOIN admissions a
ON p.patient_id = a.patient_id
JOIN doctors d
ON a.attending_doctor_id = d.doctor_id
WHERE diagnosis = 'Epilepsy' AND d.first_name='Lisa';














               














SELECT * FROM medical.medical_insurance;

CREATE TABLE insurance_staging 
LIKE medical_insurance;

-- This is done because we don't want to temper with the autual dataset

INSERT insurance_staging  
SELECT *
FROM medical_insurance;

SELECT * 
FROM insurance_staging;

-- This is done to be able to identify duplicates 
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY age, sex, bmi, 
children, smoker, region, 
charges) AS row_num
FROM insurance_staging; 

WITH duplicate_cte AS (
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY age, sex, bmi, 
children, smoker, region, 
charges) AS row_num
FROM insurance_staging)

SELECT *
FROM duplicate_cte
WHERE row_num > 1; -- From this Syntax, we can now identify the duplicate entries 

-- The below syntax is executed just so we can query the row num, using the MYSQL we can't query of a cte function 

CREATE TABLE `insurance_staging1` (
  `age` int DEFAULT NULL,
  `sex` text,
  `bmi` double DEFAULT NULL,
  `children` int DEFAULT NULL,
  `smoker` text,
  `region` text,
  `charges` double DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci; -- row_num has been successfully added to the dataset

SELECT *
FROM insurance_staging1;

INSERT INTO insurance_staging1
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY age, sex, bmi, 
children, smoker, region, 
charges) AS row_num
FROM insurance_staging; -- This allows to populate the row_num 

SELECT *
FROM insurance_staging1
WHERE row_num > 1;

DELETE
FROM insurance_staging1
WHERE row_num > 1;

------------------------------------------------------------------

/*📌 Demographics & Distribution
1.	What is the average age of policyholders?
2.	What is the distribution of policyholders by sex?
3.	How many policyholders are in each region?
4.	What is the average BMI grouped by gender?
5.	How many policyholders have children, and what is the most common number of children? */

SELECT AVG(age) 
FROM insurance_staging1;


SELECT sex, COUNT(sex)
FROM insurance_staging1
GROUP BY sex;


SELECT region, COUNT(region)
FROM insurance_staging1 
GROUP BY region;


SELECT sex, ROUND(AVG(bmi), 3) Avg_Ibm
FROM insurance_staging1
GROUP BY sex;


SELECT COUNT(*) AS num_with_children
FROM insurance_staging1
WHERE children > 0;

-- Most common number of children
SELECT children, COUNT(*) AS count
FROM insurance_staging1
GROUP BY children
ORDER BY count DESC
LIMIT 1;


/* 💰 Charges & Cost Analysis
6.	What is the average, minimum, and maximum medical charge?
7.	What is the average charge for smokers vs non-smokers?
8.	What is the average charge by region?
9.	Which region has the highest average medical cost?
10.	How does the average charge vary across different age groups? */

SELECT ROUND(AVG(charges), 1) AS Avg_charge,
	ROUND(MIN(charges), 1) AS lowest_charge,
	ROUND(MAX(charges), 1) AS highest_charge
FROM insurance_staging1;


SELECT smoker, ROUND(AVG(charges), 1) AS Avg_charge
FROM insurance_staging1
GROUP BY smoker;

SELECT region, ROUND(AVG(charges), 1) AS Avg_charge
FROM insurance_staging1
GROUP BY region 
ORDER BY Avg_charge DESC 
LIMIT 1;

SELECT region, ROUND(AVG(charges),1) AS Avg_cost
FROM insurance_staging1
GROUP BY region
ORDER BY Avg_cost DESC
LIMIT 1;

-- How does the average charge vary across different age groups?

SELECT DISTINCT age 
FROM insurance_staging1
ORDER BY age;

 SELECT   
 CASE 
	WHEN Age BETWEEN 18 AND 19 THEN '18-19'
    WHEN Age BETWEEN 20 AND 29 THEN '20-29'
    WHEN Age BETWEEN 30 AND 39 THEN '30-39'
    WHEN Age BETWEEN 40 AND 49 THEN '40-49'
    WHEN Age BETWEEN 50 AND 59 THEN '50-59'
    ELSE  '60+'
END AS Age_Group,
ROUND(AVG(charges), 1) AS Avg_charge
FROM insurance_staging1
GROUP BY Age_Group
ORDER BY Age_Group ASC;

/*⚖️ BMI & Health Indicators
11.	What is the average BMI of smokers vs non-smokers?
12.	What is the correlation between BMI and charges? (via SQL bucket analysis)
13.	How many policyholders have a BMI above 30 (classified as obese)?
14.	What is the average charge for individuals with BMI over 30 vs under 30? */

SELECT smoker, ROUND(AVG(bmi), 2) AS Avg_Bmi
FROM insurance_staging1
GROUP BY smoker;  

SELECT 
  CASE 
    WHEN bmi < 18.5 THEN 'Underweight'
    WHEN bmi BETWEEN 18.5 AND 24.9 THEN 'Normal weight'
    WHEN bmi BETWEEN 25 AND 29.9 THEN 'Overweight'
    WHEN bmi BETWEEN 30 AND 34.9 THEN 'Obese I'
    WHEN bmi BETWEEN 35 AND 39.9 THEN 'Obese II'
    ELSE 'Obese III'
  END AS bmi_category,
  COUNT(*) AS count,
  ROUND(AVG(charges), 1) AS avg_charges
FROM insurance_staging1
GROUP BY bmi_category
ORDER BY avg_charges DESC;


SELECT COUNT(*) AS No_of_holders
FROM insurance_staging1
WHERE bmi > 30;

SELECT 
  CASE 
    WHEN bmi > 30 THEN 'Over 30'
    ELSE '30 or Below'
  END AS bmi_group,
  COUNT(*) AS num_people,
  ROUND(AVG(charges), 2) AS avg_charges
FROM insurance_staging1
GROUP BY bmi_group;

/*👨‍👩‍👧 Family & Dependents
15.	What is the average charge based on number of children?
16.	Do people with more children tend to have higher charges?
17.	What is the distribution of smokers by number of children?*/

SELECT COUNT(*) AS num_of_children, ROUND(AVG(charges), 1) AS Avg_charge
FROM insurance_staging1
WHERE children > 0;

SELECT children, ROUND(SUM(charges), 1) AS Total_charges
FROM insurance_staging1
GROUP BY children
ORDER BY children DESC;

SELECT smoker, COUNT(children) AS no_of_children
FROM insurance_staging1
GROUP BY smoker
ORDER BY 2 DESC;


/*🧮 Combined Analysis
18.	What is the average charge by smoker status and region?
19.	What is the average charge by sex and smoking status?
20.	What is the highest charge recorded for a non-smoker?*/

SELECT  smoker,
		region,
		ROUND(AVG(charges), 1) AS Avg_charge
FROM insurance_staging1
GROUP BY smoker, region;

SELECT sex, smoker, ROUND(AVG(charges), 1) AS Avg_charge
FROM insurance_staging1
GROUP BY sex, smoker;

SELECT smoker, ROUND(MAX(charges), 1) AS highest_charge
FROM insurance_staging1
WHERE smoker = 'no';

-------------------------------------------------------------------------

ALTER TABLE insurance_staging1
DROP COLUMN row_num;

 /*
 This syntax will delete the row_num which is not originally part of the dataset,
 it was just created so we can view and delete the duplicates
 */











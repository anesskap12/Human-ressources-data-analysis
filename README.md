# Human ressources data analysis and Dashboard
<img width="1386" height="796" alt="Dashboard" src="https://github.com/user-attachments/assets/6860d208-1331-4c4e-9899-df16e1e70b7a" />

### Overview
This project aims to deduce conlcusions from a dataset that contains informations about a companie's employees, including the gender,the race, the job titles by cleaning the Data and then Analysing it

### Dataset
the dataset used in this project is the human ressources dataset that contains information about 22000 individual, it contains the following informations(columns):
firs name , last name , birthdate, gender, race, department, job title, Location of work, hiring date, termination date, city and state

### Data Cleaning

the Most of what i did while cleaning the data was changing the data types for the columns that had date, so i had to do some changes in order for the data to be set as a date type
1. Converting birthdate to DATE Format:
```sql
UPDATE hr
SET birthdate = CASE
    WHEN birthdate LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN birthdate DATE;
```
2. Converting hire_date to DATE Format
```sql
UPDATE hr
SET hire_date = CASE
    WHEN hire_date LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;
```
3. Handling termdate (Termination Dates)
```sql
SET sql_mode = '';
UPDATE hr
SET termdate = '0000-00-00'
WHERE termdate IS NULL;

ALTER TABLE hr
MODIFY COLUMN termdate DATE;
```
4. Adding an Age column
```sql
ALTER TABLE hr ADD COLUMN age INT;

UPDATE hr
SET age = TIMESTAMPDIFF(YEAR, birthdate, CURDATE());
```

### Data Analysis


- summary of the findings:
- 
* There are more male employees
* White race is the most dominant while Native Hawaiian and American Indian are the least dominant.  
* The youngest employee is 20 years old and the oldest is 57 years old  
* 5 age groups were created (18-24, 25-34, 35-44, 45-54, 55-64). A large number of employees were between 25-34 followed by 35-44 while the smallest group was 55-64.  
* A large number of employees work at the headquarters versus remotely.  
* The average length of employment for terminated employees is around 7 years.  
* The gender distribution across departments is fairly balanced but there are generally more male than female employees.  
* The Marketing department has the highest turnover rate followed by Training. The least turn over rate are in the Research and development, Support and Legal departments.  
* A large number of employees come from the state of Ohio.  
* The net change in employees has increased over the years.  
* The average tenure for each department is about 8 years with Legal and Auditing having the highest and Services, Sales and Marketing having the lowest.



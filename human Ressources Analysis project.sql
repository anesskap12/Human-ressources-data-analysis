CREATE DATABASE project;

USE project;

SELECT * FROM hr;

ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

DESCRIBE hr;

SELECT birthdate FROM hr;

SET sql_safe_updates = 0;

UPDATE hr
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

UPDATE hr
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

SET sql_mode = '';
UPDATE hr
SET termdate = '0000-00-00'
WHERE termdate IS NULL;

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

ALTER TABLE hr ADD COLUMN age INT;

UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());

SELECT 
	min(age) AS youngest,
    max(age) AS oldest
FROM hr;

SELECT count(*) FROM hr WHERE age < 18;

SELECT COUNT(*) FROM hr WHERE termdate > CURDATE();

SELECT COUNT(*)
FROM hr
WHERE termdate = '0000-00-00';

SELECT location FROM hr;

SELECT count(*)
from hr
where termdate;

-- Gender breakdown of the employees

select gender,count(*) as count
from hr
where age > 18 and termdate= '0000-00-00'
group by gender;

-- Race breakdown of the employees

select race,count(*)
from hr
where age>18 and termdate='0000-00-00'
group by race
order by count(*) desc;

-- age breakdown of the employees

select age,count(*)
from hr 
where age>18 and termdate='0000-00-00'
group by age
order by age asc;

select
min(age) as Youngest,
max(age) as Oldest
from hr
where age>18 and termdate='0000-00-00';

select
case
	when age>=18 and age <=24 then '18-24'
    when age>=25 and age <=34 then '25-34'
    when age>=35 and age <=44 then '35-44'
    when age>=45 and age <=54 then '45-54'
    when age>=55 and age <=64 then '55-64'
    else '65+'
 end as age_group,gender,
 count(*) as count
 from hr
 where age>18 and termdate='0000-00-00'
 group by age_group,gender
 order by age_group;
 
 -- the number of employees working in the headquarters vs the remote employees
 select count(*),
 location
 from hr
 where age>18 and termdate='0000-00-00'
 group by location;
 
 -- the Average employement's length of the terminated employees
 select
 round(avg((datediff(termdate,hire_date))/365.0)) as Average_employement
 from hr
 where age>18 and termdate<>'0000-00-00' and termdate <= CURDATE();
 
 -- Gender variation across the departments and the job titles
 select department,gender,
 count(*)
 from hr
 where age >18 and termdate='0000-00-00'
 group by department,gender
 order by department;
 
 -- the gender distribution across the different jobs
SELECT jobtitle, COUNT(*) as count
FROM hr
WHERE age >= 18
GROUP BY jobtitle
ORDER BY jobtitle DESC;

-- departments with the highest rate of the turnover rate

SELECT department,
total_count,terminated_count,
terminated_count/total_count as turnover_rate
from(
	select department,
    count(*) as total_count,
    sum(case when termdate <> '0000-00-00' and termdate<=curdate() then 1 else 0 end) as terminated_count
    from hr
    where age>18
    group by department
    ) as subquery
order by turnover_rate desc;

-- the distribution of employees across locations by state

SELECT location_state, COUNT(*) as count
FROM hr
WHERE age >= 18
GROUP BY location_state
ORDER BY count DESC;
-- the net change of employees over the years
SELECT 
    YEAR(hire_date) AS year, 
    COUNT(*) AS hires, 
    SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminations, 
    COUNT(*) - SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS net_change,
    ROUND(((COUNT(*) - SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END)) / COUNT(*) * 100),2) AS net_change_percent
FROM 
    hr
WHERE age >= 18
GROUP BY 
    YEAR(hire_date)
ORDER BY 
    YEAR(hire_date) ASC;
    
-- the tenure for each department

select
department,round(avg(datediff(termdate,hire_date)/365),0) as avg_tenure
from hr
where termdate<>'0000-00-00' and termdate < curdate() and age>18
group by department;




 
 








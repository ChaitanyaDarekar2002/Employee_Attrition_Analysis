select * from [Employee Attrition]

-- What is the total number of employees in the company?

select COUNT(*) as Total_employee from [Employee Attrition]

-- How many employees have left the company?

select count(*) as Total_Count from  [Employee Attrition] where Attrition='1'

-- What is the overall employee attrition rate?
go
CREATE VIEW vw_AttritionRate AS
SELECT 
    (SUM(CASE WHEN Attrition = '1' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS AttritionRate
FROM [Employee Attrition];

-- Which department has the highest attrition rate?
go
create view vw_MaxDepartmentAttrition as
select Department,COUNT(*) as Total_Employee from [Employee Attrition] where Attrition='1'
group by Department
order by Total_Employee desc

-- Which job role has the highest employee attrition?

create view vw_MaxjobroleAttrition as
select JobRole,COUNT(*) as Total_employee from [Employee Attrition] where Attrition='1'
group by JobRole
order by Total_employee desc

-- What is the average age of employees?

select avg(age) as AVG_AgeEmployee from [Employee Attrition]

-- What is the average monthly income by department?

select Department,AVG(MonthlyIncome) as avg_monthly_income from [Employee Attrition]
group by Department
order by avg_monthly_income desc

-- What is the gender distribution of employees?

select Gender,count(*) as Total_Employee from [Employee Attrition]

-- Does overtime affect employee attrition?

SELECT OverTime,COUNT(*) AS TotalLeft FROM [Employee Attrition]
WHERE Attrition='1'
GROUP BY OverTime;

-- What is the average monthly income of employees who left?

select AVG(MonthlyIncome) as avg_Monthlyincome from [Employee Attrition] where Attrition='1'

-- What is the average monthly income of employees who stayed?

select AVG(MonthlyIncome) as avg_Monthlyincome from [Employee Attrition] where Attrition='0'

-- Which age group has the highest attrition rate?

CREATE VIEW vw_AgeGroupAttrition AS

SELECT

CASE
WHEN Age BETWEEN 18 AND 24 THEN '18-24'
WHEN Age BETWEEN 25 AND 29 THEN '25-29'
WHEN Age BETWEEN 30 AND 34 THEN '30-34'
WHEN Age BETWEEN 35 AND 39 THEN '35-39'
ELSE '40+'
END AS AgeGroup,

COUNT(*) AS TotalEmployees

FROM [Employee Attrition]

GROUP BY
CASE
WHEN Age BETWEEN 18 AND 24 THEN '18-24'
WHEN Age BETWEEN 25 AND 29 THEN '25-29'
WHEN Age BETWEEN 30 AND 34 THEN '30-34'
WHEN Age BETWEEN 35 AND 39 THEN '35-39'
ELSE '40+'
END;

-- Who are the highest-paid employees?

select top 1  max(MonthlyIncome) as highest_Paid from [Employee Attrition]

-- Who are the lowest-paid employees?

select top 1  min(MonthlyIncome) as highest_Paid from [Employee Attrition]

-- What is the average number of years employees stay in the company?

select AVG(YearsAtCompany) as avg_Years from [Employee Attrition]

-- Which marital status category has the highest attrition?
go 
create view vw_AttritionByMaritalStatus as
SELECT MaritalStatus,COUNT(*) TotalLeft FROM [Employee Attrition]
WHERE Attrition='1'
GROUP BY MaritalStatus
ORDER BY TotalLeft DESC;

-- How does job satisfaction impact employee attrition?

select JobSatisfaction,count(*) as total_Left from [Employee Attrition]
where Attrition='1'
group by JobSatisfaction
order by total_Left

-- How does work-life balance affect employee attrition?

SELECT WorkLifeBalance,COUNT(*) TotalLeft FROM [Employee Attrition]
WHERE Attrition='1'
GROUP BY WorkLifeBalance;

-- Does distance from home affect employee turnover?

SELECT DistanceFromHome,COUNT(*) TotalLeft FROM [Employee Attrition]
WHERE Attrition='1'
GROUP BY DistanceFromHome
ORDER BY TotalLeft DESC;

-- Which employees earn above the company's average salary?

SELECT *
FROM [Employee Attrition]
WHERE MonthlyIncome >
(
SELECT AVG(MonthlyIncome)
FROM [Employee Attrition]
);
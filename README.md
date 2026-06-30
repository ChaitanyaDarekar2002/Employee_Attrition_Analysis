# Employee Attrition Analysis — Python, SQL & Power BI

End-to-end analysis of IBM's HR Employee Attrition dataset, covering exploratory data analysis in Python, database querying with SQL, and an interactive Power BI dashboard to uncover the key drivers behind employee turnover.

## Overview

This project investigates why employees leave the organization using a dataset of 1,470 employees across 35 attributes (demographics, compensation, job role, satisfaction scores, and tenure). The workflow loads the raw data into a relational database, answers business questions with SQL, and visualizes the findings in an interactive Power BI report.

**Overall attrition rate: 16.1%** (237 of 1,470 employees)

## Dataset

| | |
|---|---|
| Source | IBM HR Analytics Employee Attrition & Performance dataset |
| Rows | 1,470 employees |
| Columns | 35 (demographic, job, compensation, and satisfaction attributes) |
| Format | CSV → loaded into SQL database |
| Missing values | None |

Key fields include `Attrition`, `Age`, `Department`, `JobRole`, `MonthlyIncome`, `OverTime`, `JobSatisfaction`, `YearsAtCompany`, and `WorkLifeBalance`.

## Tech stack

- **Python** — data cleaning, exploratory data analysis, and visualization (`/python`)
- **SQL** — data loading, cleaning, and analytical queries (`/sql`)
- **Power BI** — interactive dashboard and DAX measures (`/powerbi`)
- **Database**: [add your engine here, e.g. PostgreSQL / MySQL / SQL Server]
- **Python libraries**: pandas, numpy, matplotlib / seaborn, jupyter



## Python work

The `python/` folder contains the exploratory data analysis (EDA) performed before moving the data into SQL and Power BI. It covers:

- **Data profiling** — shape, dtypes, and missing-value check (1,470 rows × 35 columns, no nulls)
- **Univariate analysis** — distribution of attrition, age, income, and tenure
- **Bivariate analysis** — attrition rate broken down by categorical features (`OverTime`, `JobRole`, `Department`, `BusinessTravel`, `MaritalStatus`) and compared against numeric features (income, tenure, satisfaction scores) using group means
- **Correlation analysis** — Pearson correlation of all numeric features against attrition
- **Visualization** — bar charts of attrition rate by job role and overtime status, used to validate findings later reproduced in SQL and Power BI

Example snippet:

```python
import pandas as pd

df = pd.read_csv("data/Employee_Attrition.csv")

# Attrition rate by job role
attrition_by_role = (
    df.groupby("JobRole")["Attrition"]
    .apply(lambda x: (x == "Yes").mean() * 100)
    .sort_values(ascending=False)
)
print(attrition_by_role.round(1))
```

Run it yourself:

```bash
cd python
pip install -r requirements.txt
jupyter notebook eda_employee_attrition.ipynb
```

## SQL work

The `sql/` folder loads the CSV into a relational table and answers core business questions, including:

- Overall and department-level attrition rate
- Attrition rate by overtime status, job role, and marital status
- Average tenure, income, and satisfaction scores compared between employees who left and those who stayed
- Identification and removal of constant/non-informative columns (`EmployeeCount`, `StandardHours`, `Over18`)

Example query:

```sql
SELECT
    JobRole,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
    ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS attrition_rate_pct
FROM employee_attrition
GROUP BY JobRole
ORDER BY attrition_rate_pct DESC;
```

See [`sql/03_analysis_queries.sql`](sql/03_analysis_queries.sql) for the full list of queries.

## Power BI dashboard

The `.pbix` file presents an interactive view of the SQL findings, including:

- **KPI cards** — overall attrition rate, total headcount, average tenure
- **Attrition by job role and department** — bar charts highlighting high-risk roles (e.g. Sales Representatives)
- **Overtime impact** — comparison of attrition rate for employees working overtime vs. not
- **Tenure and income breakdown** — distribution of years at company and monthly income split by attrition status
- **Slicers** for department, gender, marital status, and age range

Key DAX measures used:

```dax
Attrition Rate = 
DIVIDE(
    CALCULATE(COUNTROWS(employee_attrition), employee_attrition[Attrition] = "Yes"),
    COUNTROWS(employee_attrition)
)
```

[Add a screenshot or GIF of the dashboard here]

## Key findings

- **Overtime** is the strongest single driver — employees working overtime leave at roughly 3x the rate of those who don't (30.5% vs 10.4%)
- **Sales Representatives** have the highest attrition by job role (39.8%), while Research Directors and Managers have the lowest (under 5%)
- **Frequent travelers** attrite at 24.9% vs. 8.0% for non-travelers
- **Single employees** leave at more than double the rate of married employees (25.5% vs 12.5%)
- Leavers have **less tenure, lower income (~30% less), and lower stock option levels** on average — pointing to early-career flight risk
- Satisfaction scores (job, environment, work-life balance) have a weaker relationship with attrition than structural factors like overtime and role

## How to reproduce

1. Clone this repository
2. (Optional) Run the Python EDA: `cd python && pip install -r requirements.txt && jupyter notebook eda_employee_attrition.ipynb`
3. Load `data/Employee_Attrition.csv` into your SQL database using `sql/01_create_tables.sql`
4. Run `sql/02_data_cleaning.sql` to clean and standardize the data
5. Run the queries in `sql/03_analysis_queries.sql` to reproduce the analysis
6. Open `powerbi/Employee_Attrition_Dashboard.pbix` in Power BI Desktop and refresh the data connection to point to your database

## Author

Chaitanya Darekar — Data Analyst
[GitHub](https://github.com/ChaitanyaDarekar2002) · [LinkedIn](https://linkedin.com/in/chaitanyadarekar02) · chaitanyadarekar2002@gmail.com

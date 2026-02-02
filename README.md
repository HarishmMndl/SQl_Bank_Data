# SQl_Bank_Data

This is a beginner-friendly data analytics project focused on understanding customer churn in a bank. The goal of this project is to analyze customer demographics and account behaviors to identify patterns among customers who leave the bank (churners) versus those who stay (non-churners).

The project uses SQL to import, clean, structure, and analyze data across multiple tables, applying joins, aggregation, and basic functions to extract meaningful insights.

### Project Objectives
1. Understand which attributes are more common among churners than non-churners.

2. Explore if churn can be predicted using the available variables.

3. Analyze the overall demographics of the bank's customers.

4. Compare account behavior between German, French, and Spanish customers.

5. Identify customer segments within the bank.

## Database Setup and Tables

### 1. Bank_Churn Table
```sql
drop table if exists Bank_Churn;
create table Bank_Churn(
CustomerId varchar(12) primary key,
Surname varchar(30),
CreditScore int,
Geography varchar(15),
Gender varchar(10),
Age int,
Tenure int,
Balance float,
NumOfProducts int,
HasCrCard int,
IsActiveMember int,
EstimatedSalary float,
Exited int
);
```
### 2. Analyze Churners vs Non-Churners

```sql
select 
   a.Exited,
   -- Customer Demographics
    AVG(c.Age) AS avg_age,
    AVG(c.CreditScore) AS avg_credit_score,
    -- Account Behaviors
    AVG(a.Balance) AS avg_balance,
    AVG(a.NumOfProducts) AS avg_products,
    AVG(a.Tenure) AS avg_tenure,
    -- Credit Card Ratio
    ROUND(AVG(CASE WHEN a.HasCrCard = 'Yes' THEN 1 ELSE 0 END)::numeric, 2) AS credit_card_ratio,
    -- Active Member Ratio
    ROUND(AVG(CASE WHEN a.IsActiveMember = 'Yes' THEN 1 ELSE 0 END)::numeric, 2) AS active_member_ratio
from Customer_Info as c
join Account_Info as a
on c.CustomerId = a.CustomerId
group by a.Exited;
```

### 3. Average Age of Customers
```sql
select avg(age) as avg_age
from Bank_Churn;
```

### 4. Gender Distribution

```sql
select 
    gender,
    count(customerId)
from Bank_Churn
group by gender;
```

### 5. Country-wise Customer Info

```sql
select 
    geography as Country,
    count(customerId) as Number_of_user,
    ROUND(AVG(balance)::numeric, 2) AS avg_balance,
    ROUND(avg(creditscore)::numeric, 2) as avg_credit_score
from Bank_Churn
group by geography
order by Number_of_user desc;
```

## Insights

* This project highlights basic SQL functions, aggregation, joins, and foreign key relationships.

* Shows how to analyze customer demographics and account behavior to study churn.

* Can be extended to predictive analytics by using the variables for churn prediction.


# Thank You

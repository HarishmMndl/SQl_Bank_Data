-- CREATING TABLE --

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
)

drop table if exists Account_Info;
create table Account_Info (
   CustomerId varchar(20) primary key,	
   Balance float,	
   NumOfProducts int,	
   HasCrCard varchar(10),	
   Tenure int,
   IsActiveMember varchar(10),
   Exited int
)


drop table if exists Customer_Info;
create table Customer_Info (
  CustomerId varchar(20) primary key,	
  Surname varchar(35),	
  CreditScore int,
  Geography	varchar(20),
  Gender varchar(20),	
  Age int,	
  Tenure int,
  EstimatedSalary float

)

        -- Return Table --
select * from Bank_Churn;
select * from Account_Info;
select * from Customer_Info;

-- Asked Question -- 
/* 
What attributes are more common among churners than non-churners?

Can churn be predicted using the variables in the data?

What do the overall demographics of the bank's customers look like?

Is there a difference between German, French, and Spanish customers in terms of account behavior?

What types of segments exist within the bank's customers?
*/

-- giving Foreign Key --
ALTER TABLE account_info
ADD CONSTRAINT fk_customer
FOREIGN KEY (CustomerId)
REFERENCES customer_info(CustomerId)
ON DELETE CASCADE;

-- table Join --
-- 1 chunkers
-- 0 non-chunkers

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
    ROUND(AVG(CASE WHEN a.HasCrCard = 'Yes' THEN 1 ELSE 0 END)::numeric, 2) 
        AS credit_card_ratio,

    -- Active Member Ratio
    ROUND(AVG(CASE WHEN a.IsActiveMember = 'Yes' THEN 1 ELSE 0 END)::numeric, 2) 
        AS active_member_ratio

from Customer_Info as c
join Account_Info as a
on c.CustomerId = a.CustomerId

group by a.Exited;


select 
    Exited,
	
--- Demographic ---

--Customer Average Age
select avg(age) as avg_age
   from Bank_Churn;


-- Number of male and Femail --
select 
     gender,case
	 count(customerId)
   from Bank_Churn
   group by gender;


-- Number of People from each country,average balance
select 
     geography as Country,
	 count(customerId) as Number_of_user,
	 ROUND(AVG(balance)::numeric, 2) AS balance,
	 Round(avg(creditscore)::numeric, 2) as CreditScore,
	 
    from Bank_Churn
	group by geography
	order by Number_of_user desc



select * from bank_Churn;


	
   


   




create database  if not exists Walmart;
use Walmart;

#1- Undersrtanding Dataset
select * from walmart_data limit 5;
select * from product limit 5;

# - Counting Number of Rows
select count(*) from walmart_data;     # - 1100136(1M+ ROWS)
select count(*) from product;          # 3631(Rows or unique Products)

# - Describing Dataset
describe product;          
describe walmart_data;		 
                           
show columns from product;
show columns from walmart_data;



# checking All product id are unique  or not
select product_id,count(*) from product
group by product_id
having count(*)>1;


#2 - Changing Schema Design 


# Assigning Primary key to Product_id in product tbale since its all unique
ALTER TABLE product
modify product_id varchar(20);
Alter table product
add primary key (product_id);

Alter table product
modify Product_Category_Name varchar(20);
												# Converting columns into varchar for effective indexing
Alter table product
modify SKU varchar(20);


  # Assigning Foreign Key to Product_id in Walmart_data tale referenc eit with Primary key
alter table walmart_data
modify product_id varchar(20);
alter table walmart_data
add constraint fk_product_id
foreign key (product_id)
references product(product_id);
describe walmart_data;





#3 -Column Data Analysis(CDA)

select count(distinct user_id) from walmart_data;    

select count(distinct gender) from walmart_data;     

select count(distinct age) from walmart_data;        

select count(distinct occupation) from walmart_data;   

select count(distinct City_Category) from walmart_data; 
select distinct City_Category from walmart_data;        

select count(distinct Stay_In_Current_City_Years) from walmart_data; 
select distinct  Stay_In_Current_City_Years from walmart_data;       



 
## 4- Cleaning Data/Data Trasformation/Removing Null Values/Removing Outliers


#(a) - Checking Null Values
SELECT count(*)
FROM walmart_data
WHERE 
    gender IS NULL or
    age IS NULL OR
    occupation IS NULL OR
    city_category IS NULL OR
    Stay_In_Current_City_Years IS NULL OR            
    Marital_Status IS NULL OR
    Product_Category IS NULL OR
    Purchase IS NULL;



#(b) - Checking for Duplicate Valuesm
select count(distinct user_id) from.         
walmart_data;

select count(distinct product_id) from.        
walmart_data;
select count(product_id) from        
product;


select *,row_number()over(partition by user_id order by user_id) as "ranks"
from walmart_data;                      #Since this shows that 1 user with same user_id can have  multiple 
                                         # purchases so we willl keep it same and dont remove duplicated user_id
                                         
                                         
                                         
                                         
                                         
#(c) Checking/Removing Outliers using Z score


select count(*) from (
select *,abs(purchase-avg(purchase)over())/std(purchase)over() as "z_score"
from walmart_data) r
where r.z_score>3;




# Removing outliers and Creating Cleaned Table for further Anlaysis

create table walmart_clean as select * from (
select *,abs(purchase-avg(purchase)over())/std(purchase)over() as "z_score"   # 721 Rows are there with outliers so we will remove it
from walmart_data) r
where r.z_score<=3;





## 4 - Statistical Analysis


-- 1 What is Proportions of Sales based on gender/Age/City Category/Marital Status in Dataset


-- (a) What is Proportions of sales by gender in dataset
select * from walmart_clean;
select gender,concat(round(count(*)*100/(select count(*) from walmart_clean),2),'%') as "proportion"
from walmart_clean                               
group by gender;

-- (b) What is Proportions of sales by Age in dataset

select Age,concat(round(count(*)*100/(select count(*) from walmart_clean),2),'%') as "proportion"
from walmart_clean                                
group by Age;

-- (c) What is Proportions of sales by City in dataset
select City_Category,concat(round(count(*)*100/(select count(*) from walmart_clean),2),'%') as "proportion"
from walmart_clean                                
group by City_Category;


-- (d) What is Proportions of sales by Married/Unmmaried in dataset
select Marital_Status,concat(round(count(*)*100/(select count(*) from walmart_clean),2),'%') as "proportion"
from walmart_clean                                
group by Marital_Status;


-- 2 What is Average Purchase based on gender/Age/City Category/Marital Status in Dataset

# (a) -Average Price Per Gender Per Transaction

SELECT gender, AVG(purchase) AS avg_purchase_per_gender
FROM walmart_clean                           
GROUP BY gender;

# (b) -Average Price Per Gender/Marital Status 

SELECT gender,marital_status,AVG(purchase) AS "avg_purchase_per_gender"   
FROM walmart_clean
GROUP BY gender,marital_status                    
order by avg_purchase_per_gender;




# (c) -Average Price Per Gender/Age Group

SELECT gender,age,AVG(purchase) AS "avg_purchase_per_gender"
FROM walmart_clean
GROUP BY gender,age                       
order by avg_purchase_per_gender;




# (d) -Average Price Per Gender/City Category

SELECT gender,city_category,AVG(purchase) AS "avg_purchase_per_gender"
FROM walmart_clean
GROUP BY gender,city_category                     
order by avg_purchase_per_gender;





-- 3 - Find Highest/Lowest Purchase Based on Gender/age,City_Category,Marital_Status

## (a) - Highest and Lowest Spend by gender from specific city based on  specific age group
select gender,city_category,Age,max(purchase) as "Highest_Purchase",min(purchase) as "Lowest_Purchase"
from walmart_clean
group by gender,city_category,age
order by gender,Highest_Purchase desc,Lowest_Purchase asc;




## (b)-Highest ad Lowest spend by gender based on Marital Status
select gender,Marital_Status,max(purchase) as "Highest_Purchase",min(purchase) as "Lowest_Purchase"
from walmart_clean
group by gender,Marital_Status
order by gender,Highest_Purchase desc,Lowest_Purchase asc;







# 5 -Advanced Explanatory Data Analysis(EDA) to identify good and underperforming SKUs


#1 - What is best performing SKU  based on gender
select r.gender,R.SKU,r.Product_name,r.total_bought
from
(select w.gender,p.SKU,p.Product_name,count(*) as "total_bought",row_number()over(partition by w.gender order by count(*) desc) as "ranks"
from walmart_clean w
join 
product p
on w.product_id=p.product_id
group by gender,SKU,Product_name) r
where r.ranks=1;



#2- - What is worst performing SKU  based on gender
select r.gender,R.SKU,r.Product_name,r.total_bought
from
(select w.gender,p.SKU,p.Product_name,count(*) as "total_bought",row_number()over(partition by w.gender order by count(*) asc) as "ranks"
from walmart_clean w
join 
product p
on w.product_id=p.product_id
group by gender,SKU,Product_name) r
where r.ranks=1;




#3 - which SKU bought most and least based on CITY
select r.city_category,R.SKU,r.Product_name,r.total_bought
from
(select w.city_category,p.SKU,p.Product_name,count(*) as "total_bought",row_number()over(partition by w.city_category order by count(*) desc) as "ranks1",
row_number()over(partition by w.city_category order by count(*) asc) as "ranks2"
from walmart_clean w
join 
product p
on w.product_id=p.product_id
group by w.city_category,SKU,Product_name) r
where r.ranks1=1
or r.ranks2=1;




#4- which SKU bought most and least based on Gender+Marital Status
 select r.gender,r.marital_status,R.SKU,r.Product_name,r.total_bought
from
(select w.gender,w.marital_status,p.SKU,p.Product_name,count(*) as "total_bought",row_number()over(partition by w.gender,w.marital_status order by count(*) desc) as "ranks1",
row_number()over(partition by w.gender,w.marital_status order by count(*) asc) as "ranks2"
from walmart_clean w
join 
product p
on w.product_id=p.product_id
group by w.gender,w.marital_status,SKU,Product_name) r
where r.ranks1=1
or r.ranks2=1;





#5 - What is higest, and lowest Performcae SKUs in Computers,Mobile,Appliances,Electronics,Health,Entertainment

# using CTE(common table expression)
#Indexing the query to improve speed

CREATE INDEX idx_product_product_id ON product(product_id);
CREATE INDEX idx_wc_product_id ON walmart_clean(product_id);   # indexing to fast the joining of 2 tables
CREATE INDEX idx_category_sku ON product(Product_Category_Name, SKU); ## indexing to fast down filtering and grouping data


with q1 as (select 'Computers' as Category,r.SKU as "Highest_performing" from(
select p.SKU,count(w.product_id) as "counts" from
product p join walmart_clean w
on p.product_id=w.product_id
where p.Product_Category_Name = "Computers"
group by p.SKU
order by counts desc limit 1)r),

q2 as (select 'Mobile' as Category,r.SKU as "Highest_performing" from(
select p.SKU,count(w.product_id) as "counts" from
product p join walmart_clean w
on p.product_id=w.product_id
where p.Product_Category_Name = "Mobile"
group by p.SKU
order by counts desc limit 1)r),

q3 as (select 'Appliances' as Category,r.SKU as "Highest_performing" from(
select p.SKU,count(w.product_id) as "counts" from
product p join walmart_clean w
on p.product_id=w.product_id
where p.Product_Category_Name = "Appliances"
group by p.SKU
order by counts desc limit 1)r),

q4 as (select 'Electronics' as Category,r.SKU as "Highest_performing" from(
select p.SKU,count(w.product_id) as "counts" from
product p join walmart_clean w
on p.product_id=w.product_id
where p.Product_Category_Name = "Electronics"
group by p.SKU
order by counts desc limit 1)r),

q5 as (select 'Health' as Category,r.SKU as "Highest_performing" from(
select p.SKU,count(w.product_id) as "counts" from
product p join walmart_clean w
on p.product_id=w.product_id
where p.Product_Category_Name = "Health"
group by p.SKU
order by counts desc limit 1)r),

q6 as (select 'Entertainment' as Category,r.SKU as "Highest_performing" from(
select p.SKU,count(w.product_id) as "counts" from
product p join walmart_clean w
on p.product_id=w.product_id
where p.Product_Category_Name = "Entertainment"
group by p.SKU
order by counts desc limit 1)r),

q7 as (select 'Computers' as Category,r.SKU as "Lowest_performing" from(
select p.SKU,count(w.product_id) as "counts" from
product p join walmart_clean w
on p.product_id=w.product_id
where p.Product_Category_Name = "Computers"
group by p.SKU
order by counts asc limit 1)r),

q8 as (select 'Mobile' as Category,r.SKU as "Lowest_performing" from(
select p.SKU,count(w.product_id) as "counts" from
product p join walmart_clean w
on p.product_id=w.product_id
where p.Product_Category_Name = "Mobile"
group by p.SKU
order by counts asc limit 1)r),

q9 as (select 'Appliances' as Category,r.SKU as "Lowest_performing" from(
select p.SKU,count(w.product_id) as "counts" from
product p join walmart_clean w
on p.product_id=w.product_id
where p.Product_Category_Name = "Appliances"
group by p.SKU
order by counts asc limit 1)r),

q10 as (select 'Electronics' as Category,r.SKU as "Lowest_performing" from(
select p.SKU,count(w.product_id) as "counts" from
product p join walmart_clean w
on p.product_id=w.product_id
where p.Product_Category_Name = "Electronics"
group by p.SKU
order by counts asc limit 1)r),

q11 as (select 'Health' as Category,r.SKU as "Lowest_performing" from(
select p.SKU,count(w.product_id) as "counts" from
product p join walmart_clean w
on p.product_id=w.product_id
where p.Product_Category_Name = "Health"
group by p.SKU
order by counts asc limit 1)r),

q12 as (select 'Entertainment' as Category,r.SKU as "Lowest_performing" from(
select p.SKU,count(w.product_id) as "counts" from
product p join walmart_clean w
on p.product_id=w.product_id
where p.Product_Category_Name = "Entertainment"
group by p.SKU
order by counts asc limit 1)r)


select q1.Category, q1.Highest_performing, q7.Lowest_performing FROM q1 JOIN q7 ON q1.Category = q7.Category
UNION ALL
SELECT q2.Category, q2.Highest_performing, q8.Lowest_performing FROM q2 JOIN q8 ON q2.Category = q8.Category
UNION ALL
SELECT q3.Category, q3.Highest_performing, q9.Lowest_performing FROM q3 JOIN q9 ON q3.Category = q9.Category
UNION ALL
SELECT q4.Category, q4.Highest_performing, q10.Lowest_performing FROM q4 JOIN q10 ON q4.Category = q10.Category
UNION ALL
SELECT q5.Category, q5.Highest_performing, q11.Lowest_performing FROM q5 JOIN q11 ON q5.Category = q11.Category
UNION ALL
SELECT q6.Category, q6.Highest_performing, q12.Lowest_performing FROM q6 JOIN q12 ON q6.Category = q12.Category;





#6 - Which SKUs made lowest revenue per Brand in Each City

create index product_idx on product(product_id);
create index product_idx_1 on walmart_clean(product_id);

with q1 as 
(select p.sku,w.City_category,p.product_brand,sum(w.purchase) as "total"
from
 walmart_clean w 
 join product p 
on 
 w.product_id = p.product_id
 group by w.City_category,p.product_brand,p.sku)
select r.City_category,r.product_brand,r.SKU,r.total
from (
select q1.City_category,q1.product_brand,q1.SKU,q1.total,rank()over(partition by q1.City_category,q1.product_brand order by q1.total asc) as "ranks"
from q1) r
where r.ranks=1;





#7 - Which SKUs made highest revenue per Brand in Each City

with q1 as 
(select p.sku,w.City_category,p.product_brand,sum(w.purchase) as "total"
from
 walmart_clean w 
 join product p 
on 
 w.product_id = p.product_id
 group by w.City_category,p.product_brand,p.sku)
select r.City_category,r.product_brand,r.SKU,r.total
from (
select q1.City_category,q1.product_brand,q1.SKU,q1.total,rank()over(partition by q1.City_category,q1.product_brand order by q1.total desc) as "ranks"
from q1) r
where r.ranks=1;



#6 - Further Analysis and Predictive Analysis will be done in python 

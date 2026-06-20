drop database finance;
Create database finance;
use  finance;

SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';
-- loading data the csv file cc_data
LOAD DATA LOCAL INFILE 'C:/Users/sucha/OneDrive/Desktop/Data Analysis & Gen AI/Module 11_CapstoneProject/cc_data.csv'
INTO TABLE cc_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from cc_data
describe cc_data;

-- loading the csv file location_data
SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';
LOAD DATA LOCAL INFILE 'C:/Users/sucha/OneDrive/Desktop/Data Analysis & Gen AI/Module 11_CapstoneProject/location_data.csv'
INTO TABLE cc_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from location_data

-- Calculate the total number of transactions in the cc_data table 
SELECT COUNT(trans_num) AS Total_transactions 
from cc_data;

-- Identify the top 10 most frequent merchants in the cc_data table 
SELECT merchant,
       COUNT(*) AS transaction_count
FROM cc_data
GROUP BY merchant
ORDER BY transaction_count DESC
LIMIT 10;

-- Find the average transaction amount for each category of transactions in the cc_data table 
SELECT category , AVG(amt) FROM cc_data
GROUP BY category;

-- Determine the number of fraudulent transactions and the percentage of total transactions that they represent 
SELECT 
SUM(is_fraud) AS Total_fraud , 
((SUM(is_fraud)/count(*)) * 100) AS Percentage_fraud
FROM cc_data

-- Find the earliest and latest transaction dates in the cc_data table 
SELECT 
MIN(trans_date_trans_time) AS earliest_transaction,
MAX(trans_date_trans_time) AS latest_transaction
FROM cc_data;

-- What is the total amount spent across all transactions in the cc_data table? 
SELECT SUM(amt) as total_amount 
FROM cc_data;

-- How many transactions occurred in each category in the cc_data table? 
SELECT 
category , COUNT(*) AS Transaction_count
FROM cc_data 
Group by category

-- What is the average transaction amount for each gender in the cc_data table? 
SELECT  
AVG(amt), gender FROM cc_data
GROUP BY gender

-- Which day of the week has the highest average transaction amount in the cc_data table?
SELECT 
DAYNAME(STR_TO_DATE(trans_date_trans_time,'%d-%m-%Y %H:%i')) AS day_of_week,
ROUND(AVG(amt),2) AS avg_transaction_amount
FROM cc_data
GROUP BY day_of_week
ORDER BY avg_transaction_amount DESC
LIMIT 1;

-- Join the cc_data and location_data tables to identify the latitude and longitude of each transaction 
SELECT 
c.trans_num,c.trans_date_trans_time,
c.merchant,c.amt,l.lat,l.long
FROM cc_data c
JOIN location_data l
ON c.cc_num= l.cc_num ;


-- Identify the city with the highest population in the cc_data     
SELECT city, city_pop
FROM cc_data
ORDER BY city_pop DESC
LIMIT 1;
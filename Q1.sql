create database `adashi_staging`;
use `adashi_staging`;

show tables;

## Now Create various tables

## USERS table
CREATE TABLE users_customuser1 (
    id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(255)
);

select * from users_customuser;

## SAVINGS ACCOUNTS table
CREATE TABLE savings_savingsaccount (
    id INT PRIMARY KEY,
    owner_id INT,
    confirmed_amount BIGINT,
    is_regular_savings BOOLEAN,
    FOREIGN KEY (owner_id) REFERENCES users_customuser1(id)
);

select * from savings_savingsaccount;

## PLANS table
CREATE TABLE plans_plan (
    id INT PRIMARY KEY,
    owner_id INT,
    confirmed_amount BIGINT,
    is_a_fund BOOLEAN,
    FOREIGN KEY (owner_id) REFERENCES users_customuser1(id)
);

select * from plans_plan;

show tables;
select * from users_customuser;

## QUESTION 1 ANSWER
SELECT 
    u.id AS owner_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    COUNT(DISTINCT s.id) AS savings_count,
    COUNT(DISTINCT p.id) AS investment_count,
    ROUND(SUM(s.confirmed_amount + p.confirmed_amount) / 100, 2) AS total_deposits
FROM 
   users_customuser1 u
JOIN 
    savings_savingsaccount s ON u.id = s.owner_id AND s.is_regular_savings = 1
JOIN 
    plans_plan p ON u.id = p.owner_id AND p.is_a_fund = 1
GROUP BY 
    u.id, u.first_name, u.last_name
HAVING 
    savings_count >= 1 AND investment_count >= 1
ORDER BY 
    total_deposits DESC;

## customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits
SELECT u.id AS owner_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    COUNT(DISTINCT s.id) AS savings_count,
    COUNT(DISTINCT p.id) AS investment_count,
    ROUND(SUM(s.confirmed_amount + p.confirmed_amount) / 100, 2) AS total_deposits
FROM 
    users_customuser u
JOIN 
    savings_savingsaccount s ON u.id = s.owner_id AND s.is_regular_savings = 1
JOIN 
    plans_plan p ON u.id = p.owner_id AND p.is_a_fund = 1
WHERE 
    u.id = 1008
GROUP BY 
    u.id, u.first_name, u.last_name
HAVING 
    savings_count >= 1 AND investment_count >= 1;




  




## QUESTION 2
WITH monthly_transactions AS (
    SELECT 
        s.owner_id,
        DATE_FORMAT(s.created_at, '%m/%d/%Y') AS month,
        COUNT(*) AS monthly_tx_count
    FROM 
        savings_savingsaccount s
    GROUP BY 
        s.owner_id, DATE_FORMAT(s.created_at, '%m/%d/%Y')
),

avg_transactions_per_user AS (
    SELECT 
        owner_id,
        ROUND(AVG(monthly_tx_count), 2) AS avg_tx_per_month
    FROM 
        monthly_transactions
    GROUP BY 
        owner_id
)

SELECT 
    u.id AS owner_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    a.avg_tx_per_month,
    CASE
        WHEN a.avg_tx_per_month >= 10 THEN 'High Frequency'
        WHEN a.avg_tx_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category
FROM 
    avg_transactions_per_user a
JOIN 
   users_customuser1 u ON u.id = a.owner_id
ORDER BY 
    a.avg_tx_per_month DESC;

DESCRIBE savings_savingsaccount;
show tables;
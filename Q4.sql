## QUESTION 4
  SELECT
  u.id AS user_id,
  TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months,
  COUNT(t.id) AS total_transactions,
  SUM(t.amount) AS total_transaction_value,
  ROUND(
    (SUM(t.amount) / NULLIF(TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()), 0)) * 12 * 0.001,
    2
  ) AS estimated_clv
FROM users_customuser u
JOIN transactions_transaction t ON t.user_id = u.id
WHERE t.amount > 0
GROUP BY u.id
ORDER BY estimated_clv DESC;

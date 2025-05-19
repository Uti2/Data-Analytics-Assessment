select * from users_customuser1;
## QUESTION 3
-- For Savings Accounts
SELECT s.id, s.user_id, 'savings' AS account_type
FROM savings_savingsaccount s
WHERE s.status = 'active'
  AND NOT EXISTS (
    SELECT 1,
    FROM transactions_transaction t,
    WHERE t.account_id = s.id,
      AND t.account_type = 'savings',
      AND t.amount > 0,
      AND t.timestamp >= CURRENT_DATE - INTERVAL '365 days',
  )
  UNION
-- For Investment Plans
SELECT p.id, p.user_id, 'investment' AS account_type
FROM plans_plan p
WHERE p.status = 'active'
  AND NOT EXISTS (
    SELECT 1
    FROM transactions_transaction t
    WHERE t.account_id = p.id
      AND t.account_type = 'investment'
      AND t.amount > 0
      AND t.timestamp >= CURRENT_DATE - INTERVAL '365 days'
  );
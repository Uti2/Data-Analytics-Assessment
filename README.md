# Data-Analytics-Assessment
# QUESTION 1
I approached this by identifying the business goal (cross-sell opportunity), selecting the right tables, filtering based on plan types, joining them via foreign keys, and using aggregation to summarize customer activity. The final result highlights customers with multiple funded products and ranks them by total deposits — a key metric for identifying high-value individuals.”
## QUESTION 2
I approached this by analyzing the business need for customer segmentation, identifying relevant tables, and calculating the average number of monthly transactions per user. I used structured CTEs to break down the logic and applied a CASE statement to categorize each user based on their activity level. This approach transforms transactional data into actionable insight for marketing or customer engagement strategies.”
## QUESTION 3
Identify relevant tables: I used the savings_savingsaccount and plans_plan tables to identify active savings and investment accounts, respectively.

Define “active” accounts: I filtered only those accounts where status = 'active'.

Determine inflow activiY: I assumed inflow transactions are those with amount > 0 in a transactions_transaction table.

Date condition: I checked if any inflow transactions exist in the past 365 days using:

Use of NOT EXISTS: I used a NOT EXISTS subquery to eliminate accounts that had inflows within the last year, effectively selecting only inactive accounts.

Combine both account types: I used a UNION to merge results from savings and investment accounts.
## QUESTION 4
Calculate tenure: I calculated the number of months since signup using:
TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE())
Aggregate transaction data: I used SUM(t.amount) to get the total transaction volume and COUNT(t.id) for the transaction count.

Apply CLV formula:
i included a NULLIF safeguard to avoid division by zero for accounts with less than one month tenure.

Order customers by value: I sorted the result by estimated_clv DESC to highlight your top-value customers.

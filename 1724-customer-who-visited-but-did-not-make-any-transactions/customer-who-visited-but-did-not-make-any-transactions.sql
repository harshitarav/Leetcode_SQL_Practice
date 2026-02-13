# Write your MySQL query statement below
SELECT DISTINCT customer_id, COUNT(customer_id) OVER(PARTITION BY customer_id) AS count_no_trans
FROM Visits v
WHERE visit_id NOT IN (SELECT visit_id FROM Transactions);
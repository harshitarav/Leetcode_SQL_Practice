# Write your MySQL query statement below
WITH CTE1 AS (
SELECT user_id, action, 
CASE WHEN action = 'timeout' THEN 0
WHEN action = 'confirmed' THEN 1
END AS result
FROM Confirmations)

SELECT s.user_id, coalesce(confirmation_rate,0) AS confirmation_rate FROM Signups s LEFT JOIN (
SELECT user_id, round(AVG(result),2) AS confirmation_rate
FROM CTE1
GROUP BY user_id) AS t
ON s.user_id = t.user_id;
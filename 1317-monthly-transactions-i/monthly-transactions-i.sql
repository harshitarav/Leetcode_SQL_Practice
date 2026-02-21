WITH CTE1 AS(
SELECT LEFT(trans_date,7) AS month, country, COUNT(state) OVER(PARTITION BY country, LEFT(trans_date,7)) AS trans_count,
CASE WHEN state = 'approved' THEN 1 ELSE 0 END AS temp, state, amount FROM Transactions),

CTE2 AS(
SELECT *, dense_rank() OVER(PARTITION BY country, month ORDER BY approved_count DESC) AS pos FROM (
SELECT *, CASE WHEN temp=1 THEN (SUM(temp) OVER(PARTITION BY country, month)) ELSE 0 END AS approved_count, SUM(amount) OVER(PARTITION BY country,month) AS trans_total_amount
FROM CTE1) AS TAB1)

SELECT DISTINCT month, country, trans_count, approved_count, trans_total_amount, CASE WHEN approved_count!=0 THEN (SUM(amount) OVER(PARTITION BY country, month,state)) ELSE 0 END AS approved_total_amount FROM CTE2
WHERE pos =1;
# Write your MySQL query statement below
SELECT id FROM (
SELECT *, LAG(recordDate) OVER() AS lag_date, 
CASE
  WHEN datediff(recordDate, LAG(recordDate) OVER()) = 1 THEN LAG(temperature) OVER()
  ELSE 'NO'
END AS cond_date
FROM Weather ORDER BY recordDate) AS TAB1
WHERE cond_date != 'NO' AND temperature > cond_date;
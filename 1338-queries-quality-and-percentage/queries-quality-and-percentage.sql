# Write your MySQL query statement below
WITH CTE1 AS(
SELECT query_name, round(avg(rating/position) OVER(PARTITION BY query_name),2) AS quality, rating, COUNT(query_name) OVER(PARTITION BY query_name) AS query_count,
(SELECT COUNT(query_name) OVER(PARTITION BY query_name) WHERE rating<3) AS rat_count
FROM Queries
ORDER BY query_name),

CTE2 AS (
SELECT *, dense_rank() OVER(PARTITION BY query_name ORDER BY poor_query_percentage DESC) AS lat_rank FROM(
SELECT *, round((rat_upd/query_count)*100,2) AS poor_query_percentage FROM(
SELECT *, CASE WHEN rat_count IS NULL THEN 0 ELSE sum(rat_count) OVER(PARTITION BY query_name) END AS rat_upd FROM CTE1) AS TAB1
ORDER BY query_name,poor_query_percentage DESC) AS TAB2)

SELECT DISTINCT query_name, quality, poor_query_percentage FROM CTE2
WHERE lat_rank = 1;
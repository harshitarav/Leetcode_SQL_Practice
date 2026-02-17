# Write your MySQL query statement below
WITH CTE1 AS(
SELECT p.product_id, coalesce(units,0) AS units, coalesce(price*units,0) AS prod FROM PRICES p
LEFT JOIN UnitsSold u
ON p.product_id = u.product_id
WHERE purchase_date BETWEEN start_date AND end_date OR u.product_id IS NULL)

SELECT product_id, coalesce(round(tot/sum,2),0) AS average_price FROM (
SELECT DISTINCT product_id, sum(units) OVER(PARTITION BY product_id) AS sum, sum(prod) OVER(PARTITION BY product_id) AS tot FROM CTE1) AS TAB1;

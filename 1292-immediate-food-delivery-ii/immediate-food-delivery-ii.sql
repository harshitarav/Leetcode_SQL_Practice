WITH CTE1 AS (
SELECT *, dense_rank() OVER(PARTITION BY customer_id ORDER BY order_date) AS first_order, datediff(order_date, customer_pref_delivery_date) AS date_check FROM Delivery
ORDER BY customer_id, order_date),

CTE2 AS(
SELECT DISTINCT * FROM CTE1
WHERE first_order = 1)

SELECT(round(((SELECT COUNT(customer_id) FROM CTE2 WHERE date_check = 0)/(SELECT COUNT(*) FROM CTE2))*100,2)) AS immediate_percentage;
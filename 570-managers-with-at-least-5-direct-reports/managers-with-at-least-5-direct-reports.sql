# Write your MySQL query statement below
WITH CTE1 AS (
SELECT *, (SELECT id FROM Employee WHERE id = TAB1.managerId) AS id, (SELECT name FROM Employee WHERE id = TAB1.managerId) AS name FROM (
SELECT managerId, COUNT(managerId) AS manager_count
FROM Employee
GROUP BY managerId
HAVING managerId IS NOT NULL) AS TAB1)

SELECT name FROM CTE1
WHERE manager_count >=5 AND id IS NOT NULL;
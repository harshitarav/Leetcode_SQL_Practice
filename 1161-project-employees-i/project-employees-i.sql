# Write your MySQL query statement below
SELECT project_id, round(AVG(experience_years),2) AS average_years FROM (
SELECT p.project_id, e.experience_years FROM Project p LEFT JOIN Employee e
ON p.employee_id = e.employee_id) AS TAB1
GROUP BY project_id;
# Write your MySQL query statement below
WITH CTE1 AS(
SELECT t1.machine_id, t1.process_id, t2.timestamp - t1.timestamp AS time_diff FROM (
SELECT * FROM Activity
WHERE activity_type = 'start'
ORDER by machine_id, process_id) AS t1 JOIN 
(SELECT * FROM Activity
WHERE activity_type = 'end'
ORDER by machine_id, process_id) AS t2
ON t1.machine_id = t2.machine_id AND t1.process_id = t2.process_id)

SELECT machine_id, round(AVG(time_diff),3) AS processing_time FROM CTE1
GROUP BY machine_id;

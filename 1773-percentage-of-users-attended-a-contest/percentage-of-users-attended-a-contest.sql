WITH CTE1 AS(
SELECT *, (SELECT COUNT(user_id) FROM Users) AS tot_users FROM (
SELECT contest_id, COUNT(contest_id)AS contest_count FROM Register
GROUP BY contest_id
ORDER BY contest_id ASC) AS TAB1)

SELECT contest_id, round((contest_count/tot_users)*100,2) AS percentage
FROM CTE1
ORDER BY percentage DESC, contest_id ASC;
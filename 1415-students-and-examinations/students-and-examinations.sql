# Write your MySQL query statement below
SELECT TAB1.student_id, TAB1.student_name, TAB1.subject_name, coalesce(attended_exams,0) AS attended_exams FROM (
SELECT * FROM Students st LEFT JOIN Subjects su
ON coalesce(st.student_name, 'NULL') != su.subject_name) AS TAB1 LEFT JOIN (
SELECT student_id, subject_name, COUNT(subject_name) AS attended_exams FROM Examinations
GROUP BY student_id, subject_name
ORDER BY student_id) AS TAB2
ON TAB1.student_id = TAB2.student_id AND TAB1.subject_name = TAB2.subject_name
WHERE TAB1.subject_name IS NOT NULL
ORDER BY student_id, subject_name;
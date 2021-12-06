-- DELIVERABLE 1
DROP TABLE IF EXISTS retirement_info CASCADE;
SELECT employees.emp_no,
     employees.first_name,
     employees.last_name,
     titles.title,
     titles.from_date,
     titles.to_date
INTO retirement_info
FROM employees
INNER JOIN titles
ON (employees.emp_no = titles.emp_no)
WHERE employees.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY employees.emp_no, titles.to_date DESC
;
SELECT * FROM retirement_info
ORDER BY emp_no ASC;

DROP TABLE IF EXISTS unique_titles CASCADE;
SELECT DISTINCT ON (employees.emp_no) employees.emp_no,
     employees.first_name,
     employees.last_name,
     titles.title,
     titles.from_date,
     titles.to_date
INTO unique_titles
FROM employees
INNER JOIN titles
ON employees.emp_no = titles.emp_no
WHERE employees.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY employees.emp_no, titles.to_date DESC
;
SELECT * FROM unique_titles
ORDER BY emp_no ASC;

DROP TABLE IF EXISTS retiring_titles CASCADE;
SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles 
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT(ut.emp_no) DESC, ut.title 
;
SELECT * FROM retiring_titles;

-- DELIVERABLE 2
DROP TABLE IF EXISTS mentorship_eligibilty CASCADE;
SELECT DISTINCT ON (employees.emp_no) employees.emp_no,
     employees.first_name,
     employees.last_name,
     employees.birth_date,
	 dept_manager.from_date,
	 dept_manager.to_date,
	 titles.title
INTO mentorship_eligibilty
FROM dept_manager
LEFT JOIN employees
ON dept_manager.emp_no = employees.emp_no
LEFT JOIN titles
ON dept_manager.emp_no = titles.emp_no
ORDER BY employees.emp_no ASC, dept_manager.from_date ASC
;
SELECT * FROM mentorship_eligibilty;




--Insertion 
Insert Into departments(department_name, manager_id) values
('IT', NULL);

Select * from Departments;

Insert INTO users(first_name, last_name, email, department_id, role) values
('LeBron', 'James', 'lebron@buffalo.edu', 6, 'Director of IT');
('Kurian', 'Vadakara', 'kurianva@buffalo.edu', 6, 'Associate'),
('Krish', 'Puwar', 'krishpuw@buffalo.edu', 6, 'Associate'),
('Josh', 'Allen', 'joshallen1@buffalo.edu', 6, 'Associate'),
('Lamar', 'Jackson', 'lamarjack1@buffalo.edu', 6, 'Associate');

--Deletion
Delete from users
where first_name = 'Josh' and last_name ='Allen';

Delete from expenses
where user_id = 837 and expense_name = 'Taxi Fare';

--Update
UPDATE departments
SET manager_id = 1000
WHERE department_id = 5;
Select * from Departments;
UPDATE departments
SET manager_id = 3
WHERE department_id = 2;

UPDATE departments
SET manager_id = 4
WHERE department_id = 3;

--order
Select *
From expenses
Order by amount desc;

Select *
From assets
Order by purchase_date asc;

--groupby
SELECT d.department_name,
SUM(e.amount) AS total_expenses
FROM expenses e
JOIN departments d
ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY total_expenses DESC;

--subquery
SELECT *
FROM expenses e
JOIN users u
ON e.user_id = u.user_id
WHERE e.amount > (SELECT AVG(amount) FROM expenses);

--procedure
create or replace procedure add_asset(p_name varchar, p_type varchar, p_date date, p_value numeric, p_department int)
language plpgsql
as $$
begin
insert into assets(asset_name, asset_type, purchase_date, value, department_id)
values (p_name, p_type, p_date, p_value, p_department);
commit;
end;
$$;

call add_asset('building', 'property', '2025-02-16 09:15:44', 4000000, 4)
Select * from assets
where asset_name = 'building';

--function
create  function dept_user_count(dept_name VARCHAR)
returns INTEGER 
language plpgsql as $$
DECLARE d_count INTEGER;
BEGIN 
SELECT COUNT(*)
INTO d_count
FROM users u
JOIN departments d ON u.department_id = d.department_id
WHERE d.department_name = dept_name;
RETURN d_count;
END;
$$;





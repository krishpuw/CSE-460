
--Insertion 
Insert Into departments(department_name, manager_id) values
('IT', NULL);

Insert Into Expenses (expense_id, expense_name, amount, department_id, user_id)
values (350, ’Office Supplies’, 4540.65, 1, 659);


--Update
UPDATE departments
SET manager_id = 1000
WHERE department_id = 5;

UPDATE departments
SET manager_id = 3
WHERE department_id = 2;

UPDATE departments
SET manager_id = 4
WHERE department_id = 3;

--Deletion
Delete from users
where user_id = 1003;

Delete from expenses
where user_id = 837 and expense_name = 'Taxi Fare';

--groupby
SELECT d.department_name,
SUM(e.amount) AS total_expenses
FROM expenses e
JOIN departments d
ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY total_expenses DESC;

--order
Select *
From expenses
Order by amount desc;

Select *
From assets
Order by purchase_date asc;


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

--optimatization
SELECT *
FROM Expenses
WHERE user_id = 487;

CREATE INDEX idx_expenses_user ON
Expenses(user_id);


SELECT u.first_name, u.last_name,
d.department_name
FROM Users u
JOIN Departments d ON u.department_id =
d.department_id;

CREATE INDEX idx_users_department ON
Users(department_id)

SELECT department_id, COUNT(*), SUM(value)
FROM Assets
GROUP BY department_id;

CREATE INDEX idx_assets_department
ON Assets (department_id);



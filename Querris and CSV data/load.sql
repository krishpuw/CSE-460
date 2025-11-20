--users data
COPY users (first_name, last_name, email, department_id, role)
FROM 'C:\\Users\\Public\\users_clean.csv'
DELIMITER ','
CSV HEADER;

--assests
COPY assets (asset_name, asset_type, purchase_date, value, department_id)
FROM 'C:\\Users\\Public\\assets_clean.csv'
DELIMITER ','
CSV HEADER;

--departments

COPY departments (department_name, manager_id)
FROM 'C:\\Users\\Public\\departments_clean.csv'
DELIMITER ','
CSV HEADER;

--liabilities
COPY liabilities (liability_name, amount, due_data, department_id)
FROM 'C:\\Users\\Public\\liabilities_clean.csv'
DELIMITER ','
CSV HEADER;

--expenses
COPY expenses (expense_name, amount, department_id, user_id)
FROM 'C:\\Users\\Public\\expenses_clean.csv'
DELIMITER ','
CSV HEADER;

COPY transactions (transaction_type, amount, related_id, user_id)
FROM 'C:\\Users\\Public\\transactions_clean.csv'
DELIMITER ','
CSV HEADER;

--bookkeeping
COPY bookkeeping (transaction_id, account_name, debit, credit, entry_date, notes)
FROM 'C:\\Users\\Public\\bookkeeping_clean.csv'
DELIMITER ','
CSV HEADER;

--audit_logs
COPY audit_logs (user_id, action_type, table_name, record_id, time, notes)
FROM 'C:\\Users\\Public\\audit_logs_clean.csv'
DELIMITER ','
CSV HEADER;






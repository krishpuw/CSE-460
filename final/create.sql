CREATE TABLE IF NOT EXISTS Departments (
    department_id SERIAL PRIMARY KEY,
    department_name TEXT NOT NULL,
    manager_id INT 
);

CREATE TABLE IF NOT EXISTS Users (
    user_id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    department_id INT NOT NULL,
    role TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS Assets (
    asset_id SERIAL PRIMARY KEY,
    asset_name TEXT NOT NULL,
    asset_type TEXT NOT NULL,
    purchase_date DATE NOT NULL,
    value NUMERIC(15,2) NOT NULL,
    department_id INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Liabilities (
    liability_id SERIAL PRIMARY KEY,
    liability_name TEXT NOT NULL,
    amount NUMERIC(15,2) NOT NULL,
    due_date DATE NOT NULL,
    department_id INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Expenses (
    expense_id SERIAL PRIMARY KEY,
    expense_name TEXT NOT NULL,
    amount NUMERIC(15,2) NOT NULL,
    department_id INT NOT NULL,
    user_id INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Transactions (
    transaction_id SERIAL PRIMARY KEY,
    transaction_type TEXT NOT NULL,
    amount NUMERIC(15,2) NOT NULL,
    related_id INT NOT NULL,
    user_id INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Bookkeeping (
    entry_id SERIAL PRIMARY KEY,
    transaction_id INT NOT NULL,
    account_name TEXT NOT NULL,
    debit NUMERIC(15,2) NOT NULL,
    credit NUMERIC(15,2) NOT NULL,
    entry_date DATE NOT NULL,
    notes TEXT
);

CREATE TABLE IF NOT EXISTS Audit_Logs (
    log_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    action_type TEXT NOT NULL,
    table_name TEXT NOT NULL,
    record_id INT NOT NULL,
    "timestamp" TIMESTAMP NOT NULL,
    notes TEXT
);




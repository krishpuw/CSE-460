# CSE 460 — Accounting & Financial Database

A relational database project (PostgreSQL) modeling the core accounting operations of a company: departments, employees, assets, liabilities, expenses, transactions, double-entry bookkeeping, and audit logging.

Built for CSE 460 (Database Systems), taught by Prof. Shamsad Parvin.

**Team:** Krish Puwar ([@krishpuw](https://github.com/krishpuw)), Kurian Zacharia Vadakara, David Pang

## Overview

The database supports a simplified accounting workflow: departments have employees, employees generate expenses and manage assets/liabilities, every financial event is recorded as a transaction, transactions are posted to a bookkeeping ledger (debits/credits), and all changes are tracked in an audit log.

## Schema

| Table | Purpose | Key columns |
|---|---|---|
| `Departments` | Org units | `department_id` PK, `manager_id` |
| `Users` | Employees | `user_id` PK, `department_id` FK, `role` |
| `Assets` | Owned assets per department | `asset_id` PK, `value`, `department_id` FK |
| `Liabilities` | Owed amounts per department | `liability_id` PK, `amount`, `due_date`, `department_id` FK |
| `Expenses` | Employee expenses | `expense_id` PK, `department_id` FK, `user_id` FK |
| `Transactions` | Financial events (asset purchase, expense payment, liability settlement) | `transaction_id` PK, `transaction_type`, `related_id`, `user_id` FK |
| `Bookkeeping` | Double-entry ledger tied to transactions | `entry_id` PK, `transaction_id` FK, `debit`, `credit` |
| `Audit_Logs` | Record of INSERT/UPDATE/DELETE/APPROVE actions | `log_id` PK, `user_id` FK, `action_type`, `table_name`, `record_id` |

Full DDL is in [`final/create.sql`](final/create.sql).

## Repository structure

```
final/
  create.sql        # Table definitions (run first)
  load.sql          # COPY statements to load CSVs into the tables
  query.sql         # Sample DML/DQL: inserts, updates, deletes, joins,
                     #   subqueries, a stored procedure, a function, and
                     #   indexing/optimization examples
  datafiles/        # Cleaned CSVs used by load.sql (assets, users, expenses,
                     #   liabilities, transactions, bookkeeping, audit_logs)
  readme.txt        # Original phase-2 write-up (data source notes)
sql.py              # Generates the seed CSV data using Faker (1000 users,
                     #   150 assets, 350 expenses, etc.)
Dashboard Link       # Link to the Tableau dashboard built on this data
Project Demo         # Link to a recorded project walkthrough
```

## Setup

1. **Create a PostgreSQL database**, then run the schema:
   ```bash
   psql -d your_database -f final/create.sql
   ```
2. **(Optional) Regenerate the seed data** with Faker:
   ```bash
   pip install faker
   python sql.py
   ```
   This writes fresh CSVs (`users.csv`, `assets.csv`, etc.) to the working directory. The cleaned versions already used by this project live in `final/datafiles/`.
3. **Load the data.** `final/load.sql` uses `COPY ... FROM` with local Windows-style paths (`C:\Users\Public\...`) — update these to point at wherever your CSVs actually live (e.g. the files in `final/datafiles/`) before running:
   ```bash
   psql -d your_database -f final/load.sql
   ```
4. **Run sample queries** from `final/query.sql` to explore inserts/updates/deletes, aggregation, subqueries, the `add_asset` stored procedure, the `dept_user_count` function, and the indexing examples.

## Data generation

`sql.py` uses the [Faker](https://pypi.org/project/Faker/) library plus Python's `random` module to synthesize realistic data across five departments (Accounting, Tax, Advisory, Audit, HR), with enough rows in each table (1000+ users, 3000+ rows overall) to meet the project's minimum data requirements.

## Links

- **Dashboard:** see [`Dashboard Link`](Dashboard%20Link) — Tableau dashboard built on this dataset
- **Demo:** see [`Project Demo`](Project%20Demo) — recorded walkthrough of the project

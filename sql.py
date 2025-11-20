import csv
import random
from datetime import datetime, timedelta
from faker import Faker

fake = Faker()

# ------------------ CONFIG ------------------
DEPARTMENTS = ["Accounting", "Tax", "Advisory", "Audit", "HR"]

ROW_COUNTS = {
    "users": 1000,
    "assets": 150,
    "liabilities": 350,
    "expenses": 350,
    "transactions": 550,
    "bookkeeping": 350,
    "audit_logs": 250,
}
# --------------------------------------------


def random_past_date(years_back=3):
    days = random.randint(0, years_back * 365)
    return (datetime.today() - timedelta(days=days)).date()


# ------------------ WRITE CSV HELPERS ------------------

def write_csv(filename, header, rows):
    with open(filename, "w", newline="", encoding="utf-8") as f:
        writer = csv.writer(f)
        writer.writerow(header)
        writer.writerows(rows)
    print(f"✔ Created {filename} ({len(rows)} rows)")


# ------------------ DATA GENERATION ------------------

def generate_departments():
    rows = []
    for i, name in enumerate(DEPARTMENTS, start=1):
        rows.append([i, name, None])  # manager_id = None
    write_csv("departments.csv", ["department_id", "department_name", "manager_id"], rows)
    return [i for i in range(1, len(DEPARTMENTS) + 1)]


def generate_users(department_ids):
    rows = []
    roles = [
        "Senior Accountant", "Staff Accountant", "Tax Specialist",
        "Auditor", "HR Coordinator", "Financial Analyst",
        "Manager", "Intern"
    ]
    for user_id in range(1, ROW_COUNTS["users"] + 1):
        rows.append([
            user_id,
            fake.first_name(),
            fake.last_name(),
            fake.unique.email(),
            random.choice(department_ids),
            random.choice(roles)
        ])
    write_csv("users.csv",
              ["user_id", "first_name", "last_name", "email", "department_id", "role"],
              rows)
    return list(range(1, ROW_COUNTS["users"] + 1))


def generate_assets(department_ids):
    rows = []
    asset_types = ["Laptop", "Desktop", "Printer", "Server", "Furniture", "Vehicle", "Software"]
    for asset_id in range(1, ROW_COUNTS["assets"] + 1):
        rows.append([
            asset_id,
            f"{fake.word().capitalize()} {random.choice(['Pro', 'Max', 'Plus'])}",
            random.choice(asset_types),
            random_past_date(),
            round(random.uniform(500, 50000), 2),
            random.choice(department_ids)
        ])
    write_csv("assets.csv",
              ["asset_id", "asset_name", "asset_type", "purchase_date", "value", "department_id"],
              rows)
    return list(range(1, ROW_COUNTS["assets"] + 1))


def generate_liabilities(department_ids):
    rows = []
    for lid in range(1, ROW_COUNTS["liabilities"] + 1):
        due_offset = random.randint(-180, 365)
        due_date = (datetime.today() + timedelta(days=due_offset)).date()
        rows.append([
            lid,
            fake.sentence(nb_words=3).rstrip("."),
            round(random.uniform(1000, 100000), 2),
            due_date,
            random.choice(department_ids)
        ])
    write_csv("liabilities.csv",
              ["liability_id", "liability_name", "amount", "due_date", "department_id"],
              rows)
    return list(range(1, ROW_COUNTS["liabilities"] + 1))


def generate_expenses(department_ids, user_ids):
    rows = []
    names = ["Client Lunch", "Taxi Fare", "Office Supplies",
             "Cloud Subscription", "Training Workshop", "Conference Fee"]
    for eid in range(1, ROW_COUNTS["expenses"] + 1):
        rows.append([
            eid,
            random.choice(names),
            round(random.uniform(20, 5000), 2),
            random.choice(department_ids),
            random.choice(user_ids)
        ])
    write_csv("expenses.csv",
              ["expense_id", "expense_name", "amount", "department_id", "user_id"],
              rows)
    return list(range(1, ROW_COUNTS["expenses"] + 1))


def generate_transactions(user_ids, asset_ids, expense_ids, liability_ids):
    rows = []
    for tid in range(1, ROW_COUNTS["transactions"] + 1):

        tx_type = random.choice(["Asset", "Expense", "Liability"])
        user_id = random.choice(user_ids)

        if tx_type == "Asset":
            related_id = random.choice(asset_ids)
            t_label = "Asset Purchase"
            amount = round(random.uniform(500, 50000), 2)
        elif tx_type == "Expense":
            related_id = random.choice(expense_ids)
            t_label = "Expense Payment"
            amount = round(random.uniform(20, 5000), 2)
        else:
            related_id = random.choice(liability_ids)
            t_label = "Liability Settlement"
            amount = round(random.uniform(1000, 100000), 2)

        rows.append([
            tid,
            t_label,
            amount,
            related_id,
            user_id
        ])

    write_csv("transactions.csv",
              ["transaction_id", "transaction_type", "amount", "related_id", "user_id"],
              rows)

    return list(range(1, ROW_COUNTS["transactions"] + 1))


def generate_bookkeeping(transaction_ids):
    rows = []
    accounts = ["Cash", "Accounts Payable", "Office Equipment",
                "Travel Expense", "Software Expense", "Rent Expense"]

    chosen = random.sample(transaction_ids, ROW_COUNTS["bookkeeping"])

    for entry_id, tid in enumerate(chosen, start=1):
        amount = round(random.uniform(50, 20000), 2)
        debit, credit = amount, 0.0

        rows.append([
            entry_id,
            tid,
            random.choice(accounts),
            debit,
            credit,
            random_past_date(),
            f"Auto entry for transaction {tid}"
        ])

    write_csv("bookkeeping.csv",
              ["entry_id", "transaction_id", "account_name", "debit", "credit", "entry_date", "notes"],
              rows)


def generate_audit_logs(user_ids):
    rows = []
    actions = ["INSERT", "UPDATE", "DELETE", "APPROVE"]
    tables = ["assets", "liabilities", "expenses", "transactions", "bookkeeping", "departments", "users"]

    for lid in range(1, ROW_COUNTS["audit_logs"] + 1):
        rows.append([
            lid,
            random.choice(user_ids),
            random.choice(actions),
            random.choice(tables),
            random.randint(1, 2000),
            datetime.now() - timedelta(minutes=random.randint(0, 100000)),
            f"Auto log {lid}"
        ])

    write_csv("audit_logs.csv",
              ["log_id", "user_id", "action_type", "table_name", "record_id", "timestamp", "notes"],
              rows)


# ------------------ MAIN ------------------

def main():
    dept_ids = generate_departments()
    user_ids = generate_users(dept_ids)
    asset_ids = generate_assets(dept_ids)
    liability_ids = generate_liabilities(dept_ids)
    expense_ids = generate_expenses(dept_ids, user_ids)
    transaction_ids = generate_transactions(user_ids, asset_ids, expense_ids, liability_ids)
    generate_bookkeeping(transaction_ids)
    generate_audit_logs(user_ids)

    print("\n🎉 All CSV files generated successfully.\n")


if __name__ == "__main__":
    main()

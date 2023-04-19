"""Скрипт для заполнения данными таблиц в БД Postgres."""
import csv
import os
import psycopg2

CUSTOMERS_FILENAME = os.path.join("north_data", "customers_data.csv")
EMPLOYEES_FILENAME = os.path.join("north_data", "employees_data.csv")
ORDERS_FILENAME = os.path.join("north_data", "orders_data.csv")

def add_customer(cur, id: str, company: str, contact: str):
    if id and company and contact:
        cur.execute("""
            INSERT INTO customers (customer_id, company_name, contact_name)
                 VALUES (%s, %s, %s)
        """, (id, company, contact))

def load_customers(conn):
    with open(CUSTOMERS_FILENAME) as f:
        reader = csv.DictReader(f)

        for c in reader:
            add_customer(conn, c["customer_id"], c["company_name"], c["contact_name"])

def add_employee(cur, first_name, last_name, title, birth_date, notes):
    if first_name and last_name and title:
        cur.execute("""
            INSERT INTO employees (first_name, last_name, title, birthdate, notes)
                 VALUES (%s, %s, %s, %s, %s)
        """, (first_name, last_name, title, birth_date, notes))

def load_employees(conn):
    with open(EMPLOYEES_FILENAME) as f:
        reader = csv.DictReader(f)

        for c in reader:
            add_employee(conn, c["first_name"], c["last_name"], c["title"], c["birth_date"], c["notes"])

def add_order(cur, order_id, customer_id, employee_id, order_date, ship_city):
    if order_id and customer_id and employee_id:
        cur.execute("""
            INSERT INTO orders (order_id, customer_id, employee_id, order_date, ship_city)
                 VALUES (%s, %s, %s, %s, %s)
        """, (order_id, customer_id, employee_id, order_date, ship_city))

def load_orders(conn):
    with open(ORDERS_FILENAME) as f:
        reader = csv.DictReader(f)

        for c in reader:
            add_order(conn, c["order_id"], c["customer_id"], c["employee_id"],
                      c["order_date"], c["ship_city"])


def main():
    try:
        with psycopg2.connect(host="192.168.1.43",
                              database="north", user="postgres", password="postgres") as conn:
            with conn.cursor() as cur:
                load_customers(cur)
                load_employees(cur)
                load_orders(cur)
    except Exception as e:
        print(f'Ошибка при загрузке данных: {str(e)}')


if __name__ == "__main__":
    main()
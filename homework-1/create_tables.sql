-- SQL-команды для создания таблиц


CREATE TABLE customers (
    customer_id VARCHAR(5) PRIMARY KEY,
    company_name VARCHAR(40) UNIQUE NOT NULL,
    contact_name VARCHAR(40) UNIQUE NOT NULL
);

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(40) UNIQUE NOT NULL,
    last_name VARCHAR(40) UNIQUE NOT NULL,
    title  VARCHAR(40) UNIQUE NOT NULL,
    birthdate DATE,
    notes TEXT
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id VARCHAR(5) REFERENCES customers(customer_id),
    employee_id INTEGER REFERENCES employees(employee_id),
    order_date DATE,
    ship_city VARCHAR(40)
);
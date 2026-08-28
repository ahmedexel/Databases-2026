-- ============================================================================
-- retail_database_setup.sql
-- Author: Dr. Bianca Schoen-Phelan
-- Module: CMPU3010 Databases 2
-- Purpose: Setup script for 'retail_db' PostgreSQL database used in Repeat CA
-- Usage: Run this script in pgAdmin4 to create the database and populate it
-- Warning: This script checks first for the existence of the retail_db object.
--    If it already exists, this will first be deleted and then created again.
-- ============================================================================

-- Drop the database if it already exists
DROP DATABASE IF EXISTS retail_db;

-- Create the database
CREATE DATABASE retail_db;

-- Connect to the database manually in pgAdmin4 before running the rest of the script

-- Test that you can connect but there shouldn't be any db objects yet.
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_catalog = 'retail_db'
  AND table_type = 'BASE TABLE';

-- another check
-- the result of this should show "retail_db". If it doesn't then
-- you are working on the wrong database and you need to change context.
SELECT current_database();


-- Begin schema definition
-- Table: customers
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);

-- Table: payments
CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    amount DECIMAL(10, 2),
    payment_date DATE
);

-- Table: rentals
CREATE TABLE rentals (
    rental_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    rental_date DATE,
    return_date DATE
);

-- Insert sample data into customers
INSERT INTO customers (first_name, last_name, email) VALUES
('Alice', 'Smith', 'alice.smith@example.com'),
('Bob', 'Johnson', 'bob.johnson@example.com'),
('Carol', 'Williams', 'carol.williams@example.com');

-- Insert sample data into payments
INSERT INTO payments (customer_id, amount, payment_date) VALUES
(1, 45.00, '2023-01-15'),
(1, 60.00, '2023-02-10'),
(2, 30.00, '2023-01-20'),
(2, 25.00, '2023-03-05'),
(3, 120.00, '2023-02-25');

-- Insert sample data into rentals
INSERT INTO rentals (customer_id, rental_date, return_date) VALUES
(1, '2023-01-10', '2023-01-12'),
(1, '2023-02-08', '2023-02-10'),
(2, '2023-01-18', '2023-01-20'),
(3, '2023-02-22', '2023-02-24');

-- check for input
SELECT * FROM customers;
SELECT * FROM payments;
SELECT * FROM rentals;

-- =====================================================
-- Database: Giltech Online Cyber
-- Purpose : Manage Customers, Services, Staff,
--           Orders, and Payments
-- Author  : Gilisho Leteipa
-- =====================================================

-- ======================
-- Create Database
-- ======================
DROP DATABASE IF EXISTS giltech_cyber;
CREATE DATABASE giltech_cyber;
USE giltech_cyber;

-- =====================================================
-- TABLES
-- =====================================================

-- ======================
-- Customers Table
-- ======================
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) UNIQUE,
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ======================
-- Services Table
-- ======================
CREATE TABLE Services (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    service_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    price DECIMAL(10,2) NOT NULL
);

-- ======================
-- Staff Table
-- ======================
CREATE TABLE Staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    staff_name VARCHAR(100) NOT NULL,
    role VARCHAR(50),
    email VARCHAR(100) UNIQUE
);

-- ======================
-- Orders Table
-- ======================
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    staff_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
);

-- ======================
-- OrderDetails Table
-- (Many-to-Many between Orders & Services)
-- ======================
CREATE TABLE OrderDetails (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    service_id INT NOT NULL,
    quantity INT DEFAULT 1,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (service_id) REFERENCES Services(service_id)
);

-- ======================
-- Payments Table
-- ======================
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('Cash','M-Pesa','Card') NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- =====================================================
-- SAMPLE DATA INSERTS
-- =====================================================

-- Insert Customers
INSERT INTO Customers (full_name, phone, email) VALUES
('John Doe', '0712345678', 'john@example.com'),
('Jane Smith', '0798765432', 'jane@example.com'),
('Emily Clark', '0723456789', 'emily@example.com');

-- Insert Services
INSERT INTO Services (service_name, description, price) VALUES
('Printing', 'Black & white or color printing services', 20.00),
('Scanning', 'Document scanning services', 15.00),
('Internet Browsing', 'Hourly internet browsing', 50.00),
('KRA PIN Application', 'Assistance with KRA services', 200.00),
('HELB Application', 'Student HELB loan application support', 150.00);

-- Insert Staff
INSERT INTO Staff (staff_name, role, email) VALUES
('Alice Johnson', 'Attendant', 'alice@giltech.com'),
('Bob Williams', 'Manager', 'bob@giltech.com');

-- Insert Orders
INSERT INTO Orders (customer_id, staff_id) VALUES
(1, 1), -- John Doe served by Alice
(2, 1), -- Jane Smith served by Alice
(3, 2); -- Emily Clark served by Bob

-- Insert OrderDetails
INSERT INTO OrderDetails (order_id, service_id, quantity) VALUES
(1, 1, 2),  -- John Doe ordered 2 printouts
(1, 2, 1),  -- John Doe scanned 1 document
(2, 3, 1),  -- Jane Smith used internet browsing
(2, 4, 1),  -- Jane Smith did KRA PIN application
(3, 5, 1);  -- Emily Clark applied for HELB

-- Insert Payments
INSERT INTO Payments (order_id, amount, payment_method) VALUES
(1, 55.00, 'Cash'),
(2, 250.00, 'M-Pesa'),
(3, 150.00, 'Card');

-- =====================================================
-- INDEXES (for optimization)
-- =====================================================
CREATE INDEX idx_customer_phone ON Customers(phone);
CREATE INDEX idx_service_name ON Services(service_name);

-- =====================================================
-- SAMPLE QUERIES
-- =====================================================

-- 1. List all customers
SELECT * FROM Customers;

-- 2. Get all services offered by Giltech Online Cyber
SELECT * FROM Services;

-- 3. Show all orders with customer and staff info
SELECT o.order_id, c.full_name AS Customer, s.staff_name AS Staff, o.order_date
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Staff s ON o.staff_id = s.staff_id;

-- 4. Show order details with services
SELECT o.order_id, c.full_name, sv.service_name, od.quantity
FROM OrderDetails od
JOIN Orders o ON od.order_id = o.order_id
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Services sv ON od.service_id = sv.service_id;

-- 5. Calculate total payments per customer
SELECT c.full_name, SUM(p.amount) AS TotalPaid
FROM Payments p
JOIN Orders o ON p.order_id = o.order_id
JOIN Customers c ON o.customer_id = c.customer_id
GROUP BY c.full_name;

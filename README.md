# 📂 Giltech Online Cyber – Database Management System

## 📌 Project Overview
This project implements a **relational database** for **Giltech Online Cyber**, a business offering cybercafé services such as printing, scanning, browsing, government applications (KRA, HELB), and payment tracking.

The system manages:
- 👥 Customers  
- 👨‍💼 Staff  
- 🛠 Services  
- 🧾 Orders & Order Details  
- 💳 Payments  

It is built using **MySQL** and designed for **DBeaver / MySQL Workbench** execution.

---

## ⚙️ Features
- **Customer Management** – Store and track customer details  
- **Services Management** – List all cyber services with pricing  
- **Orders** – Track which customer was served by which staff member  
- **Order Details** – Many-to-Many relationship between orders and services  
- **Payments** – Track payments with different methods (Cash, M-Pesa, Card)  
- **Indexes** – Improve query performance  
- **Sample Queries** – Ready-to-use SQL queries for reporting  

---

## 🏗 Database Schema
**Tables included:**
1. `Customers` – customer information  
2. `Staff` – staff details  
3. `Services` – list of services  
4. `Orders` – orders placed by customers and served by staff  
5. `OrderDetails` – services linked to orders  
6. `Payments` – payments linked to orders  

**Relationships:**
- One-to-Many: Customers → Orders  
- One-to-Many: Staff → Orders  
- Many-to-Many: Orders ↔ Services (via OrderDetails)  
- One-to-One: Orders → Payments  

---

## 🚀 How to Run

### 1️⃣ Setup the Database
1. Open **MySQL Workbench**  
2. Connect to your MySQL server  
3. Copy the script file (`giltech_cyber.sql`) into a new SQL editor  
4. Run the script to create the database and populate it with sample data  

Or via CLI:
```bash
mysql -u root -p < giltech_cyber.sql

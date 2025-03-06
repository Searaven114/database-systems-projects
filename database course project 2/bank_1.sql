DROP DATABASE IF EXISTS bank;
CREATE DATABASE bank;
USE bank;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

CREATE TABLE customers (
	id INT PRIMARY KEY AUTO_INCREMENT,
	username VARCHAR(50) NOT NULL,
	hashed_password VARCHAR(255) NOT NULL,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	dob DATE NOT NULL,
    gender VARCHAR(50),
	phone VARCHAR(30) NOT NULL,
	email VARCHAR(150)
) AUTO_INCREMENT = 1;

INSERT INTO customers (username, hashed_password, first_name, last_name, dob, phone, email) VALUES
('johnsmith', 'hashedpass123', 'John', 'Smith', '2002-02-11', '1234567891', 'john.smith@example.com'),
('emilyjones', 'hashedpass124', 'Emily', 'Jones', '2000-01-16', '1234567892', 'emily.jones@example.com'),
('michaelbrown', 'hashedpass125', 'Michael', 'Brown', '1995-05-10', '1234567893', 'michael.brown@example.com'),
('laurawilson', 'hashedpass126', 'Laura', 'Wilson', '1991-07-25', '1234567894', 'laura.wilson@example.com'),
('chrisevans', 'hashedpass127', 'Chris', 'Evans', '1985-09-02', '1234567895', 'chris.evans@example.com'),
('sarahmiller', 'hashedpass128', 'Sarah', 'Miller', '1981-11-16', '1234567896', 'sarah.miller@example.com'),
('jamesdavis', 'hashedpass129', 'James', 'Davis', '1970-10-05', '1234567897', 'james.davis@example.com'),
('lisapatel', 'hashedpass130', 'Lisa', 'Patel', '2000-01-09', '1234567898', 'lisa.patel@example.com'),
('robertlee', 'hashedpass131', 'Robert', 'Lee', '1965-10-28', '1234567899', 'robert.lee@example.com'),
('janeclark', 'hashedpassword132', 'Jane', 'Clark', '1972-04-12', '0987654322', 'jane.clark@example.com');

-- ------------------------------------------------------------------ --

CREATE TABLE account_types (
	id INT PRIMARY KEY,
	name VARCHAR(40) NOT NULL UNIQUE
);

INSERT INTO account_types (id, name) VALUES
(1,'Savings'),
(2,'Access_savings'),
(3,'Checking'),
(4,'Businness'),
(5,'Student');
-- ------------------------------------------------------------------ --

CREATE TABLE accounts (
	id INT PRIMARY KEY AUTO_INCREMENT,
	customer_id INT NOT NULL,
	account_type_id INT NOT NULL,
	balance DECIMAL(10,2) NOT NULL DEFAULT 0,
    branch_id INT NOT NULL,
	created_at DATETIME NOT NULL DEFAULT current_timestamp(),
	updated_at DATETIME DEFAULT NULL ON UPDATE current_timestamp(),
	FOREIGN KEY (customer_id) REFERENCES customers(id),
	FOREIGN KEY (account_type_id) REFERENCES account_types(id)
) AUTO_INCREMENT=1;

INSERT INTO accounts (customer_id, account_type_id, balance, branch_id) VALUES
(1, 1, 18000.00, 2),
(1, 2, 500.00, 1),
(2, 3, 1500.00, 2),
(2, 3, 7520.00, 2),
(2, 1,  450520, 1),
(5, 3,  1200.50, 3),
(6, 5,  401, 3),
(7, 2,  25000, 1),
(9, 4,  980000.50, 3),
(4, 4, 1200705.20, 1);
-- ------------------------------------------------------------------ --

CREATE TABLE banking_services ( 
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL,
	description TEXT,
	active BOOL NOT NULL
) AUTO_INCREMENT=1;

INSERT INTO banking_services (name, description, active) VALUES
('Online Banking', 'Access your account online', TRUE),
('Online Banking Demo', 'Learn about Online Banking !', FALSE),
('Loan Services', 'Finance your dreams', TRUE);
-- ------------------------------------------------------------------ --

CREATE TABLE service_enrollments (
	id INT PRIMARY KEY AUTO_INCREMENT,
	customer_id INT,
	service_id INT,
	enrollment_date DATETIME DEFAULT current_timestamp(),
	FOREIGN KEY (customer_id) REFERENCES customers(id),
	FOREIGN KEY (service_id) REFERENCES banking_services(id)
) AUTO_INCREMENT = 1;

INSERT INTO service_enrollments (customer_id, service_id) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(2, 2),
(5, 2),
(8, 2),
(6, 2);
-- ------------------------------------------------------------------ --

CREATE TABLE feedback (
	id INT PRIMARY KEY AUTO_INCREMENT,
	customer_id INT NOT NULL,
	service_id INT NOT NULL,
	comment TEXT,
	rating INT CHECK (rating > 0 AND rating <= 10),
	created_at DATETIME NOT NULL DEFAULT current_timestamp(),
	FOREIGN KEY (customer_id) REFERENCES customers(id),
	FOREIGN KEY (service_id) REFERENCES banking_services(id)
) AUTO_INCREMENT = 1;

INSERT INTO feedback (customer_id, service_id, comment, rating) VALUES
(1, 1, 'Very satisfied with the online banking service.', 9),
(2, 2, 'Happy with the loan process.', 8),
(3, 1, 'The online banking interface is intuitive and easy to use.', 8),
(4, 1, 'Had an issue with transaction history but customer support resolved it quickly.', 7),
(5, 2, 'Applying for a loan was straightforward and transparent.', 9),
(6, 1, 'Appreciate the security features for online banking.', 10),
(7, 2, 'The loan interest rates are competitive, very satisfied.', 8),
(8, 1, 'Would like more features in the mobile app.', 6),
(9, 1, 'Online banking is reliable, haven’t faced any downtimes.', 9),
(10, 2, 'The loan approval process was longer than expected.', 5);
-- ------------------------------------------------------------------ --

CREATE TABLE transaction_types (
	id INT PRIMARY KEY AUTO_INCREMENT,
	type_name VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO transaction_types (type_name) VALUES
('Deposit'),
('Withdrawal'),
('Send'),
('Receive');

-- ------------------------------------------------------------------ --

CREATE TABLE transaction_status ( 
	status_id TINYINT PRIMARY KEY,
	name VARCHAR(30) NOT NULL -- E.g., pending, completed, cancelled
);

INSERT INTO transaction_status (status_id, name) VALUES
(1, 'Pending'),
(2, 'Completed'),
(3, 'Cancelled');

-- ------------------------------------------------------------------ --

CREATE TABLE transactions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT NOT NULL,
    type_id INT NOT NULL, 
    amount DECIMAL(10,2) NOT NULL,
    transaction_date DATETIME DEFAULT current_timestamp(),
    status_id TINYINT NOT NULL, 
    FOREIGN KEY (account_id) REFERENCES accounts(id),
    FOREIGN KEY (type_id) REFERENCES transaction_types(id), 
    FOREIGN KEY (status_id) REFERENCES transaction_status(status_id)
);

INSERT INTO transactions (account_id, type_id, amount, transaction_date, status_id) VALUES
(1, 1, 200.00, NOW(), 2),
(1, 2, -50.00, NOW(), 2),
(2, 1, 150.00, NOW(), 1),
(2, 3, -20.00, NOW(), 3),
(3, 1, 500.00, NOW(), 2),
(3, 2, -100.00, NOW(), 2),
(4, 4, 250.00, NOW(), 2),
(4, 1, -30.00, NOW(), 1),
(5, 3, 1000.00, NOW(), 2),
(5, 2, -200.00, NOW(), 2);

-- ------------------------------------------------------------------ --

CREATE TABLE transaction_notes ( 
	id INT PRIMARY KEY AUTO_INCREMENT,
	transaction_id INT,
	note TEXT, -- Additional notes about the transaction status
	updated_at DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
	FOREIGN KEY (transaction_id) REFERENCES transactions(id)
) AUTO_INCREMENT = 1;

INSERT INTO transaction_notes (transaction_id, note, updated_at) VALUES
(1, 'Initial deposit confirmed', NOW()),
(2, 'Withdrawal at ATM', NOW()),
(3, 'Transfer to savings account', NOW()),
(4, 'Payment received for invoice #1234', NOW()),
(5, 'Automatic bill payment for utilities', NOW()),
(6, 'Deposit from payroll', NOW()),
(7, 'Transfer to external account', NOW()),
(8, 'Fee for overdraft', NOW()),
(9, 'Interest payment credited', NOW()),
(10, 'Correction for duplicate charge', NOW());





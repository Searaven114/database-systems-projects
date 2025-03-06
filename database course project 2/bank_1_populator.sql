-- Populator for bank DB

-- Inserting customers TAMAM
INSERT INTO customers (username, hashed_password, first_name, last_name, age, phone, email) VALUES
('johnsmith', 'hashedpass123', 'John', 'Smith', 32, '1234567891', 'john.smith@example.com'),
('emilyjones', 'hashedpass124', 'Emily', 'Jones', 29, '1234567892', 'emily.jones@example.com'),
('michaelbrown', 'hashedpass125', 'Michael', 'Brown', 35, '1234567893', 'michael.brown@example.com'),
('laurawilson', 'hashedpass126', 'Laura', 'Wilson', 27, '1234567894', 'laura.wilson@example.com'),
('chrisevans', 'hashedpass127', 'Chris', 'Evans', 34, '1234567895', 'chris.evans@example.com'),
('sarahmiller', 'hashedpass128', 'Sarah', 'Miller', 31, '1234567896', 'sarah.miller@example.com'),
('jamesdavis', 'hashedpass129', 'James', 'Davis', 28, '1234567897', 'james.davis@example.com'),
('lisapatel', 'hashedpass130', 'Lisa', 'Patel', 26, '1234567898', 'lisa.patel@example.com'),
('robertlee', 'hashedpass131', 'Robert', 'Lee', 33, '1234567899', 'robert.lee@example.com'),
('janeclark', 'hashedpassword132', 'Jane', 'Clark', 28, '0987654322', 'jane.clark@example.com');


-- Inserting account types TAMAM
INSERT INTO account_types (id, name) VALUES
(1,'Savings'),
(2,'Access_savings'),
(3,'Checking'),
(4,'Businness'),
(5,'Student');

-- Inserting accounts TAMAM
INSERT INTO accounts (customer_id, account_type_id, balance) VALUES
(1, 1, 18000.00),
(1, 2, 500.00),
(2, 3, 1500.00),
(2, 3, 7520.00),
(2, 1,  450520),
(5, 3,  1200.50),
(6, 5,  401),
(7, 2,  25000),
(9, 4,  980000.50),
(4, 4, 1200705.20);

-- Inserting transaction status TAMAM
INSERT INTO transaction_status (status_id, name) VALUES
(1, 'Pending'),
(2, 'Completed'),
(3, 'Cancelled');

-- TAMAM
INSERT INTO transaction_types (type_name) VALUES
('Deposit'),
('Withdrawal'),
('Send'),
('Receive');


-- Inserting transactions (Note: related_transaction_id is left NULL for simplicity)
INSERT INTO transactions (account_id, type, amount) VALUES
(1, 1, 100.00),
(2, 2, 50.00),
(3, 3, 200.00),
(4, 4, 200.00);

/*
-- Assuming transaction 3 and 4 are related (send/receive pair), update to link them
UPDATE transactions SET related_transaction_id = 4 WHERE id = 3;
UPDATE transactions SET related_transaction_id = 3 WHERE id = 4;
*/

-- Inserting transaction logs
INSERT INTO transaction_logs (transaction_id, status_id, note) VALUES
(1, 2, 'Deposit completed'),
(2, 2, 'Withdrawal completed'),
(3, 2, 'Send completed'),
(4, 2, 'Receive completed');

-- Inserting bank services
INSERT INTO banking_services (name, description, active) VALUES
('Online Banking', 'Access your account online', TRUE),
('Loan Services', 'Finance your dreams', TRUE);

-- Inserting service enrollments
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

-- Inserting feedback
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
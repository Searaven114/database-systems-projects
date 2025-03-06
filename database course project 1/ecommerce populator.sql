/*
E - Commerce Store Database
	populator
*/
USE ecommerce;

-- Populating shipper table
INSERT INTO shipper (`name`, contact_name, contact_phone, `description`) VALUES 
('Aras Kargo', 'Mike Johnson', '555-4321', 'Fast and reliable shipping services.'),
('Yurtiçi Kargo', 'Sarah Lee', '555-8762', 'Eco-friendly shipping solutions.');

-- Populating customer table
INSERT INTO customer (username, hashed_password, `name`, surname, age, phone, email,balance) VALUES 
('AliceJ','$2y$10$Td1bU2I6/TXTJIzLO7Y.ne8buqZ7h.fQDiN8gQcGWs4T90ob4BO5u','Alice', 'Johnson', 25, '555-1234', 'alice.johnson@example.com',5000.0),
('BobSmith','$2y$10$gao3MLElrDcG6.ESQ1pDVu7IcG/uXSciMWqMa0lpWk/yoQ.miZ1fe', 'Bob', 'Smith', 30, '555-5678', 'bob.smith5@example.com',331231),
('Halllllie', '$2y$10$liQAeUH3ZaFRD/2n8i0MrulyyrYXovUgatHi3GqqmEvlhXbRWYGsC', 'Hallie', 'Stafford', 55, '555-1001', NULL,5000),
('bac1bag1rtan', '$2y$10$ABETfH2UbV1UAA9uGfGe..mJli9NcX44mrPE3T2EQfCiLd0CmIlru', 'Phillip', 'Bradshaw', 32, '555-1002', 'phillip.bradshaww@example.com',0),
('aness1231', '$2y$10$KwhhCe811LvabdhnyX0dDORJm.E2EYnNDthGoEMNJU.zWc79VmSjW', 'Aneesa', 'Bartlett', 24, '555-1053', NULL,10.56),
('liboWard', '$2y$10$ZhGndUDUfwxQ5NxhDCeELe9zkoIsUyZabIqZ1Jgr3QOffoXf6DwxG', 'Libbie', 'Ward', 29, '555-1914', 'libbie.ward2@example.com',50.5),
('kylamina32', '$2y$10$jTc5DMmwoG8YH2reT0nY/uEyI5ufYG2M3NR0be6tyeqodUPj4E7re', 'Kyla', 'Preston', 27, '555-1005', 'kyla.preston1@example.com',500),
('kylamina32', '$2y$10$jjTc5DmwoG8YH2reT0nY/u0$jTc5DMmwoG8YH2reT0nY/UPj4E7re', 'Kyla', 'Preston', 27, '555-1005', 'kyla.preston1@example.com',1000000),
('denvemina33', '$2y$10$jTc5DMmwoG8YH2reT0nY/uEyI5ufYG2M3NR0be6ty0b4dUPj4E7re', 'Denver', 'Preston', 28, '555-1106', 'denver.preston1@example.com',25600),
('lllex51323', '$2y$10$fTBwnvSbQ3pHKnMRjmS.fuQNQMiuTOR5xSBaFBtUYPWg2hFzPLjw6', 'Lexie', 'Watkins', 22, '555-1096', 'lexie.watkins@example.com',6543);

-- order statuses (will be converted to enumerated later on)
INSERT INTO order_status VALUES (0,'NA');
INSERT INTO order_status VALUES (1,'Received');
INSERT INTO order_status VALUES (2,'Processed');
INSERT INTO order_status VALUES (3,'Shipped');
INSERT INTO order_status VALUES (4,'Delivered');
INSERT INTO order_status VALUES (5,'Aborted');


-- Populating orders table
INSERT INTO orders ( /*order_id*/ customer_id, order_date, shipment_date, shipper_id, `status`/* last updated*/) VALUES
(7, DEFAULT, '2022-02-05 10:30:01', 2,4),
(8, DEFAULT, '2022-05-11 12:35:11', 1,4),
(5, DEFAULT, '2023-09-15 11:32:00', 2,4),
(1, DEFAULT, '2023-11-02 04:36:12', 1,4),
(9, DEFAULT, '2023-12-24 02:05:55', 2,3),
(2, DEFAULT, NULL, 2,2),
(3, DEFAULT, NULL, 2,2),
(4, DEFAULT, NULL, 2,2),
(2, DEFAULT, NULL, 2,1),
(7, DEFAULT, NULL, 2,1);

-- populating roles table
INSERT INTO roles (`name`, `description`) VALUES 
('Administrator', 'Has access to all system features and settings.'),
('Manager', 'Oversees and manages different aspects of the store, has access to reporting and employee management.'),
('Sales Associate', 'Handles customer interactions, sales, and basic customer service.'),
('Warehouse Staff',  'Manages inventory, restocks products, and prepares products for shipment.'),
('Shipper', 'Handles the shipping and delivery of products to customers.'),
('Customer Service',  'Handles customer inquiries, complaints, and returns.'),
('Product Manager',  'Manages the product listings, including adding new products, updating product information, and setting prices.'),
('Data Analyst', 'Analyzes sales data, customer behavior, and market trends to provide insights and recommendations.'),
('IT Support',  'Provides technical support and maintains the IT infrastructure.'),
('Marketing Specialist',  'Handles marketing campaigns, promotions, and advertising efforts.');


-- Populating category table
INSERT INTO category (`name`) VALUES 
('Electronics'),
('Clothing'),
('Groceries');


-- Populating supplier table
INSERT INTO supplier (`name`, contact_name, contact_phone, `description`) VALUES 
('TechSupplier Inc.', 'John Doe', '555-1234', 'Supplier of electronic goods.'),
('FashionCorp', 'Jane Smith', '555-5678', 'Clothing and apparel supplier.'),
('FoodMarket LLC', 'Jim Beam', '555-8765', 'Grocery supplier.');

-- Populating product table
INSERT INTO product (`name`, category_id, price, weight, supplier_id, `active`, `description`) VALUES 
('Smartphone', 1, 299.99, 0.5,2, TRUE, 'Latest model smartphone with advanced features.'),
('Jeans', 2, 49.99, 1.0,3, TRUE, 'Comfortable and stylish jeans.'),
('Apple', 3, 0.99, 0.2,1, TRUE, 'Fresh and juicy apple.'),
('Tablet', 1, 199.99, 0.75,1, TRUE, 'Portable and powerful tablet.'),
('Shirt', 2, 29.99, 0.5,1, TRUE, 'Casual and comfortable shirt.'),
('Banana', 3, 0.49, 0.2,2,TRUE, 'Sweet and ripe banana.'),
('Laptop', 1, 499.99, 2.0,1, TRUE, 'High-performance laptop for professionals.'),
-- ('Jacket', 2, 89.99, 1.5, FALSE, 'Warm and stylish jacket.'), -- active: FALSE kullanaran koşullu ifadeler kur, örnegin, FALSE olan bir ürün sipariş geçilememeli..
('Orange', 3, 0.79, 0.25,3, TRUE, 'Citrusy and refreshing orange.');


-- Populating inventory table
INSERT INTO inventory VALUES 
(1, 140, DEFAULT),
(2, 200, DEFAULT),
(3, 320, DEFAULT),
(4, 150, DEFAULT),
(5, 250, DEFAULT),
(6, 350, DEFAULT),
(7, 100, DEFAULT);

/*
-- Populating orders table
INSERT INTO orders (customer_id, order_date, shipment_date, shipper_id, `status`) VALUES
(7, DEFAULT, NULL, 2,1),
(8, DEFAULT, NULL, 1,0),
(5, DEFAULT, DEFAULT, 2,2),
(2, DEFAULT, DEFAULT, 1,1);
*/

/*
-- Populating ordered_items table
INSERT INTO ordered_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 299.99), -- Smartphone
(1, 4, 1, 199.99), -- Tablet
(1, 7, 1, 499.99), -- Laptop
(2, 2, 2, 49.99),  -- Jeans
(2, 5, 1, 29.99),  -- Shirt
(3, 3, 5, 0.99),   -- Apple
(3, 6, 3, 0.49),   -- Banana
(3, 7, 1, 499.99), -- Laptop
(4, 1, 1, 299.99), -- Smartphone
(4, 2, 2, 49.99);  -- Jeans
*/

INSERT INTO ordered_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 299.99), -- Smartphone
(1, 4, 1, 199.99), -- Tablet
(1, 7, 1, 499.99), -- Laptop
(2, 2, 2, 49.99),  -- Jeans
(2, 5, 2, 29.99),  -- Shirt
(3, 3, 5, 0.99),   -- Apple
(4, 6, 16, 0.49),   -- Banana
(5, 7, 1, 499.99), -- Laptop
(6, 1, 1, 299.99), -- Smartphone
(7, 2, 2, 49.99),  -- Jeans
(8, 2, 2, 49.99),  -- Jeans
(9, 2, 2, 49.99),  -- Jeans
(10, 2, 2, 49.99);  -- Jeans


INSERT INTO comments (product_id, customer_id, comment, point) VALUES
(1, 1, 'Great product', 8),
(2, 2, 'I loved it', 9),
(3, 3, 'Not bad', NULL),
(4, 4, 'Could be better', 6),
(5, 5, 'Amazing!', 10),
(6, 6, 'Just okay', 5),
(7, 7, 'I did not like it', 3),
(8, 8, 'Terrible experience', 1),
(1, 2, 'Decent product', 7),
(2, 3, 'Very good', 8),
(3, 4, NULL, 6),
(4, 5, 'I would recommend it', NULL);



/*
E - Commerce Store Database
	creator
*/

DROP DATABASE IF EXISTS ecommerce;
CREATE DATABASE ecommerce;

USE ecommerce;


CREATE TABLE shipper (

	id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(70) NOT NULL,
    contact_name VARCHAR(50) NOT NULL,
    contact_phone VARCHAR(30) NOT NULL,
    `description` TEXT	
) AUTO_INCREMENT=1;

-- ------------------------------------------------------------------ --

CREATE TABLE roles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    description TEXT
);

-- ------------------------------------------------------------------ --
    
CREATE TABLE customer (

	id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    hashed_password VARCHAR(255) NOT NULL,
	`name` VARCHAR(50) NOT NULL,
	surname VARCHAR(50) NOT NULL,
	age INT NOT NULL,
    phone VARCHAR(30) NOT NULL,
	email VARCHAR(150),
    balance DECIMAL(10,2) NOT NULL DEFAULT 0 CHECK (balance > -1),
    created DATETIME NOT NULL DEFAULT current_timestamp(),
    last_updated DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(),
    
	CONSTRAINT ageCheck CHECK (age > 0)
) AUTO_INCREMENT = 1;

-- ------------------------------------------------------------------ --

CREATE TABLE category (

	id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(40) NOT NULL UNIQUE    
) AUTO_INCREMENT=1;

-- ------------------------------------------------------------------ --

CREATE TABLE supplier (

	id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(70) NOT NULL,
    contact_name VARCHAR(50) NOT NULL,
    contact_phone VARCHAR(30) NOT NULL,
    `description` TEXT
) AUTO_INCREMENT=1;

-- ------------------------------------------------------------------ --

CREATE TABLE product (
	
    id INT NOT NULL PRIMARY KEY auto_increment,
    `name` VARCHAR(100) NOT NULL,
    category_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    weight DOUBLE NOT NULL,
    supplier_id INT NOT NULL,
    `active` BOOL NOT NULL,
    `description` TEXT,
    average_points  TINYINT,
    created DATETIME NOT NULL DEFAULT current_timestamp(),
    last_updated DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(),
    
    CONSTRAINT priceCheck CHECK (price > 0),
    CONSTRAINT weightCheck CHECK (weight > 0),
    CONSTRAINT FK_category_id FOREIGN KEY (category_id) REFERENCES category(id) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_supplier_id FOREIGN KEY (supplier_id) REFERENCES supplier(id) ON DELETE NO ACTION ON UPDATE NO ACTION
) AUTO_INCREMENT=1;

-- ------------------------------------------------------------------ --

CREATE TABLE inventory (
	
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    last_updated DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(),

    CONSTRAINT FK_product_id FOREIGN KEY (product_id) REFERENCES product(id),
    CONSTRAINT quantityCheck CHECK (quantity > -1)
);
 
 -- ------------------------------------------------------------------ --
 
 CREATE TABLE order_status (  -- (0,'NA') 1,'Received') (2,'Processed') (3,'Shipped') (4,'Delivered')
	
    status_id TINYINT PRIMARY KEY,
    `name` VARCHAR(30) NOT NULL
);

-- ------------------------------------------------------------------ --

CREATE TABLE orders ( -- Ne kadar item sipariş edilirse edilsin (order_items) TEK kargo firması postalayacak kabul ediyoruz.
	
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATETIME NOT NULL DEFAULT current_timestamp(),
    shipment_date DATETIME,
    shipper_id INT NOT NULL,
    `status` TINYINT NOT NULL DEFAULT 0, 	-- 0 -> order NA, 1 -> processing, 2 -> on the way, 3 -> delivered, 4 -> canceled (MUST BE CONVERTED TO ENUM TYPE LATER ON)
    last_updated DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(),
 	
    -- CONSTRAINT FK_customer_id FOREIGN KEY (customer_id) REFERENCES customer(id) ON DELETE CASCADE ON UPDATE CASCADE,
    -- CONSTRAINT FK_shipper_id FOREIGN KEY (shipper_id) REFERENCES shipper(id) ON DELETE NO ACTION,
    -- CONSTRAINT FK_status FOREIGN KEY (`status`) REFERENCES order_status(status_id) ON DELETE NO ACTION ON UPDATE CASCADE
) AUTO_INCREMENT = 1;

-- ------------------------------------------------------------------ --

CREATE TABLE employees ( 

	id INT PRIMARY KEY AUTO_INCREMENT,
    `role` INT NOT NULL,
	`name` VARCHAR(50) NOT NULL,
	surname VARCHAR(50) NOT NULL,
	age INT NOT NULL,
    phone VARCHAR(30) NOT NULL,
	email VARCHAR(150),
	created DATETIME NOT NULL DEFAULT current_timestamp(),
    last_updated DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(),  
    
	CONSTRAINT ageCheck2 CHECK (age > 18),
    CONSTRAINT FK_role FOREIGN KEY (`role`) REFERENCES roles(id) ON DELETE NO ACTION ON UPDATE CASCADE
) AUTO_INCREMENT = 1;

-- ------------------------------------------------------------------ --

CREATE TABLE ordered_items (

	id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT CHECK (quantity > -1),
    unit_price DECIMAL(10,2), -- cıkarılabilir
    
	-- PRIMARY KEY(order_id, id),
    CONSTRAINT FK_order_id2 FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT FK_product_id2 FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE CASCADE ON UPDATE CASCADE
) AUTO_INCREMENT = 1;

-- ------------------------------------------------------------------ --

CREATE TABLE comments ( 
	comment_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    customer_id INT NOT NULL,
    `comment` LONGTEXT,
    `point` INT CHECK ( 0 < point <= 10),
    created DATETIME NOT NULL DEFAULT current_timestamp(),
    
    CONSTRAINT FK_customer_id2 FOREIGN KEY (customer_id) REFERENCES customer(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_product_id3 FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE CASCADE ON UPDATE CASCADE
) AUTO_INCREMENT = 1;

-- ------------------------------------------------------------------ --

DELIMITER //
CREATE TRIGGER after_comment_insert
AFTER INSERT ON comments FOR EACH ROW
BEGIN
    UPDATE product SET average_points = (
        SELECT AVG(`point`) 
        FROM comments 
        WHERE product_id = NEW.product_id
    ) 
    WHERE id = NEW.product_id;
END //
DELIMITER ;


/* Info:
	-BİTMEDİ-
    E-Commerce Fonksiyonalite  (Bazıları CRUD yapabildikten sonra çok fazla önemli değil, feature kısabilirim üşenirsem/beceremezsem)
		
        - index.php(READ)
			Navbar ile User(user.html), browse(browse.php), checkout(checkout.php) ye yönlendirme olacak.
            "optionally, show a list of featured or new products with links to their details"
            "optionally, show a list of featured or new products with links to their details"
			        
                    
		- register.php (CREATE,READ)
			Forms ile customer adı, soyadı, yaşı, telefon numarası, emaili, kullanıcıAdı ve şifresi toplanacak.(zorunlu olan olmayan fieldler beyan edilecek kullanıcıya placeholder ile) 
              Toplanan bu verilerden kullanıcı adına input check uygulanacak customers.username ile eşleşme var mı diye, eğer var ise kullanıcıya bu username'nin zaten var olduğu,
              tekrar denemesi için bir bildirim çıkacak.
            
            Eğer "username already exists" hatası almazsa session message olarak, index.php ye yada success.php ye redirect edilecek. (direkt yolla indexe amk)
             "If the password is correct, it sets a session message to "Login successful!" and redirects to success.php"
			 "If the password is incorrect, it sets a session message to "Invalid username or password" and redirects back to login.php"
						
            input, INSERT operasyonu olmadan önce sanitize edilecek
				function sanitize_input($data) {
					$data = trim($data);
					$data = stripslashes($data);
					$data = htmlspecialchars($data);
					return $data;
				}
                
                $username = sanitize_input($_POST["username"]);
				$password = sanitize_input($_POST["password"]);
            
            Password DB'ye hashlenerek gelecek, check edilirken loginden girilen pw nin hash'i ile DB'den gelen customer.hashed_password karşılaştırılacak.
				$hashed_password = password_hash($password, PASSWORD_DEFAULT);
                
				if (password_verify($password, $hashed_password)) {
					// Password is correct
					$_SESSION['message'] = "Login successful!";
					header("Location: success.php");
					exit;
				} else {
					// Password is incorrect
					$_SESSION['message'] = "Invalid username or password";
					header("Location: login.php");
					exit;
				}
                
			FORM RESUBMISSION ENGELLENECEK
				// Redirect to the same page to prevent form resubmission, index'e de yollayabiliriz direkt.
				header("Location: submit.php");
				exit;

		- login.php (READ)
			Ana Auth sayfası. 
            register.php'ye redirect button'u olacak kullanıcı isterse
            "if (password_verify($password, $hashed_password))" conditionu ile authentication yapılacak.
            eğer login başarılı ise customer id session variable olarak tutulacak sessionda.
			Session Timeout hem session.gc_maxlifetime configuration ayarı ile yapılacak. (optional)
            
		- logout.php (optional ?)
			Logout button'u eklenecek index.php ye.
            
            Here is what happens during the logout process:
				session_start(); – Accesses the current session based on the session cookie in the user’s browser. This allows you to access and manipulate the user’s session data.
				Clear Session Variables – All session variables are removed. This is done by setting $_SESSION to an empty array: $_SESSION = array();
				Destroy Session – The user’s session is destroyed, and their unique session ID is invalidated using session_destroy();
				Redirect – Optionally, you can redirect the user to the login page or another page of your choice.
					
        - user.html (READ, DELETE, UPDATE)
			customer bilgisi display edilecek,
            customer kendi bilgisini degistirebilecek (optional),
            user bakiye ekleyebilecek(simulasyon)
            hesap silme fonksiyonalitesi eklenecek, silmek isterse sessiondan id'si alınıp, customers.id ile eşleşilen girdi silinecek. (easy)
            şifre değiştirme fonksiyonalitesi eklenecek, değiştirmek isterse id'si alınıp, customers.id ile eşleşilen row'un username si değiştirilecek. (easy)
		
        
        - browse.php
			products daki itemler display edilecek (https://prnt.sc/iRKdreNziZAH gibi)
        
        
        - checkout.php
			Checkout boş ise, sayfada checkout'un boş olduğu yazacak, işlem yapılamayacak ve itemlerin oldugu browse.php ye redirect button'u olacak.
        
    
    
*/

/* TODO

DB tarafında:

	trigger kullanımı eklenecek
	naming düzeltilecek, bazı degiskenler cogul bazıları tekil
    status 0 veya 1 iken, TID NULL dısında baska bir sey olmamalı triggeri ekle
    
    
    

*/








    

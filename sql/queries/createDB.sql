CREATE DATABASE IF NOT EXISTS sales_system;

USE sales_system;

CREATE TABLE category (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    deleted_at DATETIME DEFAULT NULL
);

CREATE TABLE product (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price FLOAT NOT NULL,
    category_id INT,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    deleted_at DATETIME DEFAULT NULL,
    FOREIGN KEY (category_id) REFERENCES category(id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE branch (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    deleted_at DATETIME DEFAULT NULL
);

CREATE TABLE customer (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    branch_id INT,
    age INT NOT NULL,
    email VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    deleted_at DATETIME DEFAULT NULL,
    FOREIGN KEY (branch_id) REFERENCES branch(id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE purchase (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    total FLOAT NOT NULL,
    status ENUM('vigente', 'pagado', 'cancelado') NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    deleted_at DATETIME DEFAULT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE purchase_product (
    purchase_id INT,
    product_id INT,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    deleted_at DATETIME DEFAULT NULL,
    PRIMARY KEY (purchase_id, product_id),
    FOREIGN KEY (purchase_id) REFERENCES purchase(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO category (name, created_at, updated_at) VALUES
('Electronics', NOW(), NOW()),
('Clothing', NOW(), NOW()),
('Home Appliances', NOW(), NOW()),
('Books', NOW(), NOW()),
('Toys', NOW(), NOW());

INSERT INTO product (name, price, category_id, created_at, updated_at) VALUES
('Laptop', 1200.00, 1, NOW(), NOW()),
('Jeans', 40.00, 2, NOW(), NOW()),
('Microwave', 150.00, 3, NOW(), NOW()),
('Novel', 20.00, 4, NOW(), NOW()),
('Action Figure', 25.00, 5, NOW(), NOW());

INSERT INTO branch (name, created_at, updated_at) VALUES
('Downtown', NOW(), NOW()),
('Suburb', NOW(), NOW()),
('Online', NOW(), NOW());

INSERT INTO customer (name, branch_id, age, email, created_at, updated_at) VALUES
('John Doe', 1, 30, 'johndoe@example.com', NOW(), NOW()),
('Jane Doe', 2, 25, 'janedoe@example.com', NOW(), NOW()),
('Bob Smith', 3, 28, 'bobsmith@example.com', NOW(), NOW());

INSERT INTO purchase (customer_id, total, status, created_at, updated_at) VALUES
(1, 1240.00, 'pagado', NOW(), NOW()),
(2, 40.00, 'pagado', NOW(), NOW()),
(3, 175.00, 'cancelado', NOW(), NOW()),
(1, 20.00, 'pagado', NOW(), NOW()),
(2, 25.00, 'cancelado', NOW(), NOW());

INSERT INTO purchase_product (purchase_id, product_id, created_at, updated_at) VALUES
(1, 1, NOW(), NOW()),
(2, 2, NOW(), NOW()),
(3, 3, NOW(), NOW()),
(4, 4, NOW(), NOW()),
(5, 5, NOW(), NOW());

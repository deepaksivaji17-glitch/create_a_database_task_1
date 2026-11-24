create database sale_management;
use sale_management;
CREATE TABLE productlines (
    productLine VARCHAR(50) PRIMARY KEY,
    textDescription VARCHAR(4000) DEFAULT NULL,
    htmlDescription  TEXT DEFAULT NULL,
    image BLOB DEFAULT NULL
);
CREATE TABLE products (
    productCode VARCHAR(15) PRIMARY KEY,
    productName VARCHAR(70) NOT NULL,
    productLine VARCHAR(50) NOT NULL,
    productScale VARCHAR(10) NOT NULL,
    productVendor VARCHAR(50) NOT NULL,
    productDescription TEXT NOT NULL,
    quantityInStock SMALLINT NOT NULL,
    buyPrice DECIMAL(10,2) NOT NULL,
    MSRP DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (productLine)REFERENCES productlines(productLine));
CREATE TABLE offices (
    officeCode INT PRIMARY KEY,
    city VARCHAR(50)NOT NULL,
    phone VARCHAR(50) NOT NULL,
    addressLine1 VARCHAR(50) NOT NULL,
    addressLine2 VARCHAR(50)NOT NULL,
    state VARCHAR(50) DEFAULT NULL,
    country VARCHAR(50) NOT NULL,
    postalCode VARCHAR(15) NOT NULL,
    territory VARCHAR(10) NOT NULL
);
CREATE TABLE employees (
    employeeNumber INT PRIMARY KEY,
    lastName VARCHAR(50) NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    extension VARCHAR(10) NOT NULL,
    email VARCHAR(100) NOT NULL,
    officeCode INT NOT NULL,
    reportsTo INT DEFAULT NULL,
    jobTitle VARCHAR(50) NOT NULL,
	FOREIGN KEY (officeCode)REFERENCES offices(officeCode),
	FOREIGN KEY (reportsTo)REFERENCES employees(employeeNumber)
);
CREATE TABLE customers (
    customerNumber INT PRIMARY KEY,
    customerName VARCHAR(50) NOT NULL,
    contactLastName VARCHAR(50) NOT NULL,
    contactFirstName VARCHAR(50) NOT NULL,
    phone VARCHAR(50) NOT NULL,
    addressLine1 VARCHAR(50) NOT NULL,
    addressLine2 VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) DEFAULT NULL,
    postalCode VARCHAR(15) DEFAULT NULL,
    country VARCHAR(50) NOT NULL,
    salesRepEmployeeNumber INT DEFAULT NULL,
    creditLimit DECIMAL(10,2) DEFAULT NULL,
    FOREIGN KEY (salesRepEmployeeNumber)REFERENCES employees(employeeNumber));
CREATE TABLE orders (
    orderNumber INT PRIMARY KEY,
    orderDate DATE NOT NULL,
    requiredDate DATE NOT NULL,
    shippedDate DATE DEFAULT NULL,
    status VARCHAR(15) NOT NULL,
    comments TEXT DEFAULT NULL,
    customerNumber INT NOT NULL,
    FOREIGN KEY (customerNumber)REFERENCES customers(customerNumber));
CREATE TABLE orderdetails (
    orderNumber INT NOT NULL,
    productCode VARCHAR(15) NOT NULL,
    quantityOrdered INT NOT NULL,
    priceEach DECIMAL(10,2) NOT NULL,
    orderLineNumber SMALLINT NOT NULL,
    PRIMARY KEY (orderNumber, productCode),
    FOREIGN KEY (orderNumber)REFERENCES orders(orderNumber),
    FOREIGN KEY (productCode)REFERENCES products(productCode));
CREATE TABLE payments (
    customerNumber INT NOT NULL,
    checkNumber VARCHAR(50) NOT NULL,
    paymentDate DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (customerNumber, checkNumber),
    FOREIGN KEY (customerNumber)REFERENCES customers(customerNumber));
 
INSERT INTO productlines
(productLine, textDescription, htmlDescription, image)
VALUES
('Classic Cars', 'Classic car models','classic cars only', NULL),
('BENZ CARS',' benz car models','benz cars only',null),  
('Bmw CARS',' bmw car models','bmw cars only',null),
('Buggati CARS',' buggati car models','buggati cars only',null),
('kia CARS',' kia car models','kia cars only',null),
('lamborhgini CARS',' lamborghini car models','lamborghini cars only',null);

INSERT INTO offices
(officeCode, city, phone, addressLine1, addressLine2,state, country, postalCode, territory)
VALUES
('1', 'San Francisco', '+1 650 219 4782','100 Market Street','suite 100', 'CA','USA', '94080', 'NA'),
('2','chennai','+1 890 098 999','155 jp streert','suites 200','ba','csa','08876','na');
 
INSERT INTO employees
(employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle)
VALUES
(1001, 'Smith', 'John', 'x1001', 'john@example.com', '1', NULL, 'President');

INSERT INTO products
(productCode, productName, productLine, productScale, productVendor,
productDescription, quantityInStock, buyPrice, MSRP)
VALUES
('S10_1000', 'Classic Car', 'Classic Cars', '1:18', 'Auto Vendor','Classic car model', 100, 50.00, 80.00),

('M10_2000', 'bmw car', 'bmw cars', '1:12', 'Bike Vendor','bmw car model', 150, 40.00, 65.00),

('P10_3000', 'buggati car', 'buggati cars', '1:24', 'Auto Vendor','buggati car model', 75, 60.00, 95.00);

INSERT INTO customers
(customerNumber, customerName, contactLastName, contactFirstName,phone, addressLine1, addressLine2, city, state, postalCode,country, salesRepEmployeeNumber, creditLimit)
VALUES
(101, 'ABC Motors', 'Kumar', 'Raj','9876543210', '10 Main Street', 'suite 100', 'Chennai', 'Tamil Nadu','600001', 'India', 1001, 50000.00),
(102, 'XYZ Traders', 'Sharma', 'Arun','9876543211', '20 Park Road', 'suite 200', 'Bangalore', 'Karnataka','560001', 'India', 1001, 75000.00),
(103, 'Global Cars', 'Patel', 'Vijay','9876543212', '30 MG Road','suite 400', 'Mumbai', 'Maharashtra','400001', 'India', 1001, 60000.00);

INSERT INTO orders
(orderNumber, orderDate, requiredDate, shippedDate,status, comments, customerNumber)
VALUES
(5001, '2026-08-20', '2026-08-25', '2026-08-22','Shipped', 'First order', 101),
(5002, '2026-08-21', '2026-08-27', NULL,'In Process', 'Second order', 102),
(5003, '2026-08-22', '2026-08-28', '2026-08-24','Shipped', NULL, 103);

INSERT INTO orderdetails
(orderNumber, productCode, quantityOrdered, priceEach, orderLineNumber)
VALUES
(5001, 'S10_1000', 2, 80.00, 1),
(5001, 'M10_2000', 3, 65.00, 2),
(5002, 'P10_3000', 1, 95.00, 1),
(5003, 'S10_1000', 4, 80.00, 1);

INSERT INTO payments
(customerNumber, checkNumber, paymentDate, amount)
VALUES
(101, 'CHK001', '2026-08-23', 160.00),
(102, 'CHK002', '2026-08-24', 95.00),
(103, 'CHK003', '2026-08-25', 320.00);

SELECT * FROM productlines;
SELECT * FROM offices;
SELECT * FROM employees;
SELECT * FROM products;
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM orderdetails;
SELECT * FROM payments;

select productline from productlines;
select employeeNumber,firstName,lastName from employees;

select productname,productline,productscale,productvendor,buyprice,msrp 
from products 
where msrp <=80;

select productname,productline,productscale,productvendor,buyprice,msrp 
from products 
where msrp >=80;

select productname,productline,productscale,productvendor,buyprice,msrp 
from products 
order by buyprice;

select productname,productline,productscale,productvendor,buyprice,msrp 
from products 
order by msrp;

select productname,productline,productscale,productvendor,buyprice,msrp 
from products 
order by buyprice desc;

select productname,productline,productscale,productvendor,buyprice,msrp 
from products 
order by buyprice desc
limit 2;

alter table productlines
drop image;

select * from productlines;













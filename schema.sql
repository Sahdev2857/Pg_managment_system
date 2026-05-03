DROP DATABASE IF EXISTS pg_management;
CREATE DATABASE pg_management;
USE pg_management;

-- ======================
-- PG TABLE
-- ======================
CREATE TABLE PG (
    PG_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Warden_Name VARCHAR(25),
    Address VARCHAR(200),
    Contact_Number VARCHAR(15) UNIQUE,
    Alternate_Number VARCHAR(15)
);

-- ======================
-- ROOM TABLE
-- ======================
CREATE TABLE Room (
    ROOM_ID INT PRIMARY KEY AUTO_INCREMENT,
    Room_Number INT,
    Room_Type VARCHAR(20),
    Capacity INT,
    Rent DECIMAL(10,2),
    PG_ID INT,
    FOREIGN KEY (PG_ID) REFERENCES PG(PG_ID)
);

-- ======================
-- TENANT TABLE
-- ======================
CREATE TABLE Tenant (
    Tenant_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Phone VARCHAR(15),
    Gender VARCHAR(10),
    ID_Proof VARCHAR(50),
    Joining_Date DATE,
    ROOM_ID INT,
    FOREIGN KEY (ROOM_ID) REFERENCES Room(ROOM_ID)
);

-- ======================
-- PAYMENT TABLE
-- ======================
CREATE TABLE Payment (
    Payment_ID INT PRIMARY KEY AUTO_INCREMENT,
    Tenant_ID INT,
    Amount DECIMAL(10,2),
    Payment_Date DATE,
    Payment_Mode VARCHAR(20),
    Payment_Type VARCHAR(30),
    FOREIGN KEY (Tenant_ID) REFERENCES Tenant(Tenant_ID)
);

-- ======================
-- ELECTRICITY BILL
-- ======================
CREATE TABLE Electricity_Bill (
    Bill_ID INT PRIMARY KEY AUTO_INCREMENT,
    ROOM_ID INT,
    Units_Consumed INT,
    Bill_Amount DECIMAL(10,2),
    Month VARCHAR(15),
    Due_Date DATE,
    Status VARCHAR(20),
    FOREIGN KEY (ROOM_ID) REFERENCES Room(ROOM_ID)
);

-- ======================
-- VISITOR TABLE
-- ======================
CREATE TABLE Visitor (
    Visitor_ID INT PRIMARY KEY AUTO_INCREMENT,
    Tenant_ID INT,
    Visitor_Name VARCHAR(100),
    Phone VARCHAR(15),
    Visit_Date DATE,
    In_Time TIME,
    Out_Time TIME,
    FOREIGN KEY (Tenant_ID) REFERENCES Tenant(Tenant_ID)
);

-- ======================
-- INSERT DATA
-- ======================

-- PG
INSERT INTO PG (Name, Warden_Name, Address, Contact_Number, Alternate_Number) VALUES
('Green PG','Raj','Delhi','9991110001','8881110001'),
('Blue PG','Amit','Mumbai','9991110002','8881110002'),
('Red PG','Karan','Pune','9991110003','8881110003'),
('Sky PG','Rohit','Noida','9991110004','8881110004'),
('Sun PG','Arjun','Jaipur','9991110005','8881110005'),
('Moon PG','Vikas','Indore','9991110006','8881110006'),
('Star PG','Manish','Bhopal','9991110007','8881110007'),
('Lake PG','Deepak','Chennai','9991110008','8881110008'),
('Hill PG','Nikhil','Kolkata','9991110009','8881110009'),
('River PG','Sameer','Lucknow','9991110010','8881110010');

-- ROOM
INSERT INTO Room (Room_Number, Room_Type, Capacity, Rent, PG_ID) VALUES
(101,'Single',1,5000,1),
(102,'Double',2,8000,1),
(201,'Single',1,5500,2),
(202,'Double',2,8500,2),
(301,'Triple',3,10000,3),
(302,'Double',2,9000,3),
(401,'Single',1,6000,4),
(402,'Double',2,8500,4),
(501,'Triple',3,11000,5),
(502,'Single',1,6500,5);

-- TENANT
INSERT INTO Tenant (Name, Phone, Gender, ID_Proof, Joining_Date, ROOM_ID) VALUES
('Rahul','9000000001','Male','Aadhar','2024-01-01',1),
('Aman','9000000002','Male','PAN','2024-01-02',2),
('Neha','9000000003','Female','Aadhar','2024-01-03',3),
('Pooja','9000000004','Female','PAN','2024-01-04',4),
('Ravi','9000000005','Male','Aadhar','2024-01-05',5),
('Kiran','9000000006','Male','PAN','2024-01-06',6),
('Sneha','9000000007','Female','Aadhar','2024-01-07',7),
('Ankit','9000000008','Male','PAN','2024-01-08',8),
('Priya','9000000009','Female','Aadhar','2024-01-09',9),
('Varun','9000000010','Male','PAN','2024-01-10',10);

-- PAYMENT
INSERT INTO Payment (Tenant_ID, Amount, Payment_Date, Payment_Mode, Payment_Type) VALUES
(1,5000,'2024-02-01','Cash','Rent'),
(2,8000,'2024-02-01','UPI','Rent'),
(3,5500,'2024-02-01','Card','Rent'),
(4,8500,'2024-02-01','Cash','Rent'),
(5,10000,'2024-02-01','UPI','Rent'),
(6,9000,'2024-02-01','Card','Rent'),
(7,6000,'2024-02-01','Cash','Rent'),
(8,8500,'2024-02-01','UPI','Rent'),
(9,11000,'2024-02-01','Card','Rent'),
(10,6500,'2024-02-01','Cash','Rent');

-- ELECTRICITY
INSERT INTO Electricity_Bill (ROOM_ID, Units_Consumed, Bill_Amount, Month, Due_Date, Status) VALUES
(1,120,1200,'Jan','2024-02-10','Paid'),
(2,150,1500,'Jan','2024-02-10','Pending'),
(3,110,1100,'Jan','2024-02-10','Paid'),
(4,140,1400,'Jan','2024-02-10','Pending'),
(5,200,2000,'Jan','2024-02-10','Paid'),
(6,160,1600,'Jan','2024-02-10','Pending'),
(7,130,1300,'Jan','2024-02-10','Paid'),
(8,170,1700,'Jan','2024-02-10','Pending'),
(9,210,2100,'Jan','2024-02-10','Paid'),
(10,125,1250,'Jan','2024-02-10','Pending');

-- VISITOR
INSERT INTO Visitor (Tenant_ID, Visitor_Name, Phone, Visit_Date, In_Time, Out_Time) VALUES
(1,'Friend1','8000000001','2024-02-01','10:00','12:00'),
(2,'Friend2','8000000002','2024-02-01','11:00','13:00'),
(3,'Friend3','8000000003','2024-02-01','09:00','11:00'),
(4,'Friend4','8000000004','2024-02-01','10:30','12:30'),
(5,'Friend5','8000000005','2024-02-01','08:00','10:00'),
(6,'Friend6','8000000006','2024-02-01','07:00','09:00'),
(7,'Friend7','8000000007','2024-02-01','12:00','14:00'),
(8,'Friend8','8000000008','2024-02-01','13:00','15:00'),
(9,'Friend9','8000000009','2024-02-01','14:00','16:00'),
(10,'Friend10','8000000010','2024-02-01','15:00','17:00');



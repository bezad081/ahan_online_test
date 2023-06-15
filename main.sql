

CREATE TABLE Sales (
    SalesID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    Customer VARCHAR(50) NOT NULL,
    Product VARCHAR(50) NOT NULL,
    Date INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice INT NOT NULL
);

INSERT INTO Sales (SalesID, OrderID, Customer, Product, Date, Quantity, UnitPrice)
VALUES
    (1, 1, 'C1', 'P1', 1, 2, 100),
    (2, 1, 'C1', 'P2', 1, 4, 150),
    (3, 2, 'C2', 'P2', 1, 5, 150),
    (4, 3, 'C3', 'P4', 1, 3, 550),
    (5, 4, 'C4', 'P3', 1, 1, 300),
    (6, 4, 'C4', 'P6', 1, 6, 150),
    (7, 4, 'C4', 'P4', 1, 6, 550),
    (8, 5, 'C5', 'P2', 1, 3, 150),
    (9, 5, 'C5', 'P1', 1, 6, 100),
    (10, 6, 'C1', 'P6', 1, 3, 150),
    (11, 6, 'C1', 'P3', 1, 2, 300),
    (12, 7, 'C3', 'P5', 1, 4, 400),
    (13, 7, 'C3', 'P1', 1, 6, 100),
    (14, 7, 'C3', 'P3', 1, 1, 300),
    (15, 8, 'C5', 'P2', 1, 3, 150),
    (16, 8, 'C5', 'P5', 1, 4, 400),
    (17, 8, 'C5', 'P1', 1, 2, 100),
    (18, 9, 'C2', 'P3', 2, 1, 300),
    (19, 9, 'C2', 'P4', 2, 3, 550),
    (20, 9, 'C2', 'P5', 2, 6, 400),
    (21, 9, 'C2', 'P1', 2, 4, 100),
    (22, 10, 'C4', 'P6', 2, 3, 150),
    (23, 11, 'C6', 'P3', 2, 2, 300),
    (24, 11, 'C6', 'P4', 2, 3, 550),
    (25, 12, 'C7', 'P1', 2, 5, 100),
    (26, 12, 'C7', 'P2', 2, 3, 150),
    (27, 12, 'C7', 'P3', 2, 1, 300),
    (28, 13, 'C2', 'P1', 2, 4, 100),
    (29, 13, 'C2', 'P3', 2, 2, 300),
    (30, 14, 'C6', 'P2', 2, 6, 150),
    (31, 15, 'C4', 'P6', 2, 1, 150),
    (32, 16, 'C1', 'P4', 3, 6, 550),
    (33, 17, 'C2', 'P5', 3, 3, 400),
    (34, 18, 'C8', 'P1', 3, 6, 100),
    (35, 18, 'C8', 'P3', 3, 3, 300),
    (36, 18, 'C8', 'P5', 3, 5, 400),
    (37, 19, 'C9', 'P2', 3, 2, 150),
    (38, 20, 'C2', 'P3', 3, 3, 300),
    (39, 20, 'C2', 'P1', 3, 4, 100),
    (40, 20, 'C2', 'P2', 3, 1, 150);



	CREATE TABLE SaleProfit (
    Product VARCHAR(50) PRIMARY KEY,
    ProfitRatio DECIMAL(5, 2) NOT NULL
);



INSERT INTO SaleProfit (Product, ProfitRatio)
VALUES
    ('P1', 0.05),
    ('P2', 0.25),
    ('P3', 0.10),
    ('P4', 0.20),
    ('P5', 0.10);


INSERT INTO SaleProfit (Product, ProfitRatio)
VALUES ('P6', 0.10);


SELECT SUM(Quantity * UnitPrice) AS TotalSales
FROM Sales;


SELECT COUNT(DISTINCT Customer)
FROM Sales;


SELECT Product, SUM(Quantity) AS TotalQuantity
FROM Sales
GROUP BY Product;







SELECT Customer, COUNT(DISTINCT OrderID) invoice_number ,
       SUM(Quantity * UnitPrice) Purchase_amount ,
       SUM(Quantity) AS Number_of_items_purchased
FROM Sales 
 
WHERE Customer IN (
    SELECT DISTINCT Customer
    FROM Sales 
    WHERE Quantity * UnitPrice >= 1500
)
GROUP BY Customer;







SELECT 
  SUM(s.quantity * s.unitprice * sp.profitratio) AS total_profit, 
 
  100 * SUM(s.quantity * s.unitprice * sp.profitratio) / SUM(s.quantity * s.unitprice) AS profit_percentage 
FROM  sales s
  JOIN saleprofit sp ON s.product = sp.product;








SELECT COUNT(DISTINCT Customer) AS TotalCustomers
FROM Sales;



CREATE TABLE chart (
    Id int PRIMARY KEY IDENTITY(1,1),
    name varchar(50) NOT NULL,
    manager varchar(50) NULL,
    ManagerId int NULL
);

INSERT INTO chart (name, manager, ManagerId) VALUES
('Ken', NULL, NULL),
('Hugo', NULL, NULL),
('James', 'Carol', 5),
('Mark', 'Morgan', 13),
('Carol', 'Alex', 12),
('David', 'Rose', 21),
('Michael', 'Markos', 11),
('Brad', 'Alex', 12),
('Rob', 'Matt', 15),
('Dylan', 'Alex', 12),
('Markos', 'Carol', 5),
('Alex', 'Ken', 1),
('Morgan', 'Matt', 15),
('Jennifer', 'Morgan', 13),
('Matt', 'Hugo', 2),
('Tom', 'Brad', 8),
('Oliver', 'Dylan', 10),
('Daniel', 'Rob', 9),
('Amanda', 'Markos', 11),
('Ana', 'Dylan', 10),
('Rose', 'Rob', 9),
('Robert', 'Rob', 9),
('Fill', 'Morgan', 13),
('Antoan', 'David', 6),
('Eddie', 'Mark', 4);


DECLARE @chart_levels TABLE (
  Id int,
  name varchar(50),
  manager varchar(50),
  level int,
  path varchar(100)
);

INSERT INTO @chart_levels
SELECT 
  Id, 
  name, 
  manager, 
  1 AS level, 
  CAST(Id AS VARCHAR(100)) AS path 
FROM 
  chart 
WHERE 
  manager IS NULL;

DECLARE @count int = 1;

WHILE @count > 0
BEGIN
  INSERT INTO @chart_levels
  SELECT 
    c.Id, 
    c.name, 
    c.manager, 
    cl.level + 1, 
    cl.path + '.' + CAST(c.Id AS VARCHAR(100)) 
  FROM 
    chart c 
    JOIN @chart_levels cl ON c.manager = cl.name 
  WHERE 
    NOT EXISTS (
      SELECT 1 
      FROM @chart_levels 
      WHERE Id = c.Id
    );

  SET @count = @@ROWCOUNT;
END;

SELECT 
  cl.Id, 
  cl.name, 
  cl.manager, 
  cl.level
   
  
FROM 
  @chart_levels cl;

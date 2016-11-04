-- 1

CREATE TABLE ReOrder (
    ProductID integer PRIMARY KEY REFERENCES Product(ProductID),
    RequestDate DATE DEFAULT SYSDATE,
    NormalQuan  CHAR DEFAULT 'T',
    ReorderQuan INTEGER,
    CONSTRAINT ReorQuan CHECK(ReorderQuan > 0)
);

CREATE OR REPLACE VIEW PhoneInfo AS Select Name, Phone From (
    (Select FirstName || ' ' || LastName AS Name, Phone FROM Customer)
    UNION
    (Select Name, Phone FROM Club)
    UNION
    (Select Name, Phone FROM Supplier)
);

-- 2

CREATE TABLE OrderLog (
    OrderID INTEGER REFERENCES ProductOrder(OrderID),
    OrderDateTime DATE,
    CustomerID INTEGER REFERENCES Customer(CustomerID),
    OrderTotalPrice DECIMAL(5,2),
    CONSTRAINT order_log_comp_key PRIMARY KEY(OrderID, CustomerID)
);

CREATE OR REPLACE VIEW ProductStock AS (
    SELECT ProductID, ProductName, QuanInStock FROM Product
);

-- 3

CREATE TABLE ErrorLog (
    OrderID INTEGER REFERENCES ProductOrder(OrderID),
    OrderDateTime DATE,
    CustomerID INTEGER REFERENCES Customer(CustomerID),
    ProductID INTEGER REFERENCES Product(ProductID),
    Quantity INTEGER,
    ErrorMessage VARCHAR(64)
);

CREATE OR REPLACE VIEW NewOrders AS (
    SELECT * FROM ProductOrder WHERE OrderDate > TO_DATE('15-OCT-2015','DD-MON-YYYY')
);

-- 4

CREATE TABLE CustInvoice (
    InvoiceNo INTEGER PRIMARY KEY,
    CustNo INTEGER NOT NULL REFERENCES CUSTOMER(CustomerID),
    CustName VARCHAR(15),
    Street VARCHAR(25),
    Zip NUMBER(5,0)
);

CREATE OR REPLACE VIEW NewOrderDetails AS (
    SELECT O.* FROM OrderDetails O, ProductOrder P WHERE P.OrderDate >= '15-OCT-2015'
);

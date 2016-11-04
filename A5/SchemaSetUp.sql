CREATE TABLE Zipcode  (
	Zip integer PRIMARY KEY,
	City varchar(32),
	State char(2),
	CONSTRAINT cus_zip CHECK(Zip > 0)
);

CREATE TABLE Customer (
	CustomerID integer PRIMARY KEY,
	FirstName varchar(32) NOT NULL,
	LastName varchar(32) NOT NULL,
	Street varchar(32),
	Phone integer,
	Zip integer REFERENCES Zipcode(Zip)
);

CREATE TABLE Supplier (
	SupplierID varchar(8) PRIMARY KEY,
	Name varchar(32) NOT NULL,
	Street varchar(32),
	Phone integer,
	Zip integer REFERENCES Zipcode(Zip)
);

CREATE TABLE Club (
	ClubID integer PRIMARY KEY,
	Name varchar(32) NOT NULL,
	Street varchar(32),
	Phone integer,
	Zip integer REFERENCES Zipcode(Zip)
);

CREATE TABLE Member (
	MemberID integer PRIMARY KEY,
	MemberDate date,
	Duration integer,
	Amount integer,
	PaymentType varchar(8),
	ClubID integer REFERENCES Club(ClubID),
	CustomerID integer REFERENCES Customer(CustomerID)
);

CREATE TABLE Product (
	ProductID integer PRIMARY KEY,
	ProductName varchar(32) NOT NULL,
	QuanInStock integer DEFAULT 20,
	ReorderPoint integer DEFAULT 5,
	Price decimal(5,2),
	SupplierID varchar(8) REFERENCES Supplier(SupplierID),
	ReorderQuan integer DEFAULT 20
);

CREATE TABLE PurchaseOrder (
	PONo varchar(8) PRIMARY KEY,
	ProductID integer REFERENCES Product(ProductID) ON DELETE CASCADE,
	PODate date
);

CREATE TABLE ProductOrder (
	OrderID integer PRIMARY KEY,
	OrderDate date,
	ShipDate date,
	PaymentType varchar(8) DEFAULT 'CC',
	CustomerID integer REFERENCES Customer(CustomerID)
);

CREATE TABLE OrderDetails (
	OrderID integer REFERENCES ProductOrder(OrderID),
	ProductID integer REFERENCES Product(ProductID),
	Quantity integer,
	CONSTRAINT cus_pk PRIMARY KEY(OrderID, ProductID)
);

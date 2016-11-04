INSERT INTO Zipcode VALUES (34342, 'Wichita',     'KS');
INSERT INTO Zipcode VALUES (65670, 'Branson',     'MO');
INSERT INTO Zipcode VALUES (66572, 'St. Charles', 'MO');
INSERT INTO Zipcode VALUES (13567, 'New York',    'NY');
INSERT INTO Zipcode VALUES (90006, 'Los Angelas', 'CA');
INSERT INTO Zipcode VALUES (60603, 'Chicago',     'IL');
INSERT INTO Zipcode VALUES (65807, 'Springfield', 'MO');
INSERT INTO Zipcode VALUES (63140, 'St. Louis',   'MO');
INSERT INTO Zipcode VALUES (64530, 'Kansas City', 'MO');
INSERT INTO Zipcode VALUES (65810, 'Springfield', 'MO');

INSERT INTO Club VALUES (100, 'Hillside Mountain Club', '1 Winona St.',   '3163397676', 34342);
INSERT INTO Club VALUES (110, 'Branson Climbing Club',  '2 Sherwood Dr.', '4174485676', 65670);
INSERT INTO Club VALUES (120, 'Cherokee Rafting Club',  '44 Kent Ave.',   '3147780870', 66572);
INSERT INTO Club VALUES (130, 'White Plains Club',      '225 Tracy St.',  '2126678090', 13567);

INSERT INTO Supplier VALUES ('S500', 'Hillside Ski',        '2717 S Western Ave',  '7146654959', 90006);
INSERT INTO Supplier VALUES ('S510', 'Tiger Mountain',      '2600 S Vermont Ave.', '7143327878', 90006);
INSERT INTO Supplier VALUES ('S520', 'Asha Outdoor',        '44 S LaSalle St.',    '3125554678', 60603);
INSERT INTO Supplier VALUES ('S530', 'Sheraton Recreation', '225 Tracy St.',       '2128889569', 13567);
INSERT INTO Supplier VALUES ('S540', 'NY Winters',          '1903 Mich St.',       '2693871000', 60603);

INSERT INTO Customer VALUES (101, 'Jack',   'Russell',  '25 North Madison Ave', '4178823434', 65807);
INSERT INTO Customer VALUES (102, 'Betty',  'Trumbell', '550 South Court Dr.',  '3125556670', 63140);
INSERT INTO Customer VALUES (103, 'Anil',   'Kaul',     '400 South Circle St.', '4316667070', 64530);
INSERT INTO Customer VALUES (104, 'Tom',    'Wiley',    '1500 North Grand St.', '4178825560', 65810);
INSERT INTO Customer VALUES (105, 'Sharon', 'Stone',    '200 West Wagner St.',  '4176668890', 65807);

INSERT INTO Member VALUES (10010, '12-JUN-15', 4, 200, 'CC',    100, 101);
INSERT INTO Member VALUES (10020, '15-JUN-15', 2, 100, 'Check', 110, 102);
INSERT INTO Member VALUES (10030, '21-JUN-15', 5, 250, 'Check', 120, 103);

INSERT INTO Product VALUES (10010, 'Beginner''s Ski Boot',  20, 5,  9.75, 'S500', 25);
INSERT INTO Product VALUES (10011, 'Intermediate Ski Boot', 18, 5, 12.99, 'S500', 20);
INSERT INTO Product VALUES (10012, 'Pro Ski Boot',          21, 7, 15.49, 'S510', 25);
INSERT INTO Product VALUES (10013, 'Beginner''s Ski Pole',  15, 3, 25.49, 'S500', 20);
INSERT INTO Product VALUES (10014, 'Intermediate Ski Pole', 20, 3, 29.99, 'S520', 22);
INSERT INTO Product VALUES (10015, 'Pro Ski Pole',          21, 5, 34.99, 'S530', 25);
INSERT INTO Product VALUES (10016, 'Road Bicycle',          15, 4, 34.95, 'S520', 18);
INSERT INTO Product VALUES (10017, 'Mountain Bicycle',      19, 4, 49.99, 'S520', 20);
INSERT INTO Product VALUES (10018, 'Tire Pump',              8, 2,  7.99, 'S530', 10);
INSERT INTO Product VALUES (10019, 'Water Bottle',          25, 4,  2.49, 'S510', 25);
INSERT INTO Product VALUES (10020, 'Bicycle Tires',         30, 5,  4.99, 'S500', 33);
INSERT INTO Product VALUES (10021, 'Bicycle Helmet',        23, 6, 10.95, 'S510', 25);

INSERT INTO PurchaseOrder VALUES ('PO11', 10011, '25-MAY-15');
INSERT INTO PurchaseOrder VALUES ('PO12', 10015, '12-MAY-15');
INSERT INTO PurchaseOrder VALUES ('PO13', 10011, '25-JUN-15');
INSERT INTO PurchaseOrder VALUES ('PO14', 10018, '25-JUN-15');
INSERT INTO PurchaseOrder VALUES ('PO15', 10015, '10-JUL-15');
INSERT INTO PurchaseOrder VALUES ('PO16', 10019, '21-JUL-15');

INSERT INTO ProductOrder VALUES (1001, '27-MAY-15', '01-JUN-15', 'CC',    102);
INSERT INTO ProductOrder VALUES (1002, '28-MAY-15', '02-JUN-15', 'CC',    103);
INSERT INTO ProductOrder VALUES (1003, '28-MAY-15', '03-JUN-15', 'Check', 104);
INSERT INTO ProductOrder VALUES (1004, '05-JUN-15', '10-JUN-15', 'CC',    105);
INSERT INTO ProductOrder VALUES (1005, '06-JUN-15', '08-JUN-15', 'Check', 103);
INSERT INTO ProductOrder VALUES (1006, '08-JUN-15', '12-JUN-15', 'CC',    104);

INSERT INTO OrderDetails VALUES (1001, 10011, 2);
INSERT INTO OrderDetails VALUES (1001, 10015, 3);
INSERT INTO OrderDetails VALUES (1002, 10011, 5);
INSERT INTO OrderDetails VALUES (1002, 10016, 2);
INSERT INTO OrderDetails VALUES (1003, 10019, 5);
INSERT INTO OrderDetails VALUES (1004, 10018, 3);
INSERT INTO OrderDetails VALUES (1004, 10011, 1);
INSERT INTO OrderDetails VALUES (1004, 10019, 3);
INSERT INTO OrderDetails VALUES (1005, 10017, 1);
INSERT INTO OrderDetails VALUES (1005, 10019, 1);
INSERT INTO OrderDetails VALUES (1005, 10021, 1);
INSERT INTO OrderDetails VALUES (1006, 10012, 4);
INSERT INTO OrderDetails VALUES (1006, 10015, 2);

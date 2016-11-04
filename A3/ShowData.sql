SELECT ProductID, TO_CHAR(RequestDate, 'DD-MON-YYYY HH:MI:SS') AS RequestDate, NormalQuan, ReorderQuan FROM ReOrder;

SELECT OrderID, TO_CHAR(OrderDateTime, 'DD-MON-YYYY HH:MI:SS') AS OrderDateTime, CustomerID, OrderTotalPrice FROM OrderLog;

SELECT OrderID, TO_CHAR(OrderDateTime, 'DD-MON-YYYY HH:MI:SS') AS OrderDateTime, CustomerID, ProductID, Quantity, ErrorMessage FROM ErrorLog;

SELECT * FROM CustInvoice;
SELECT * FROM PhoneInfo;
SELECT * FROM ProductStock;

SELECT OrderID, TO_CHAR(OrderDate, 'DD-MON-YYYY HH:MI:SS') AS OrderDate, TO_CHAR(ShipDate, 'DD-MON-YYYY HH:MI:SS') AS ShipDate, PaymentType AS Payment FROM NewOrders;

SELECT OrderID, ProductID, Quantity FROM NewOrderDetails;

SELECT PONo, ProductID, TO_CHAR(PODate, 'DD-MON-YYYY HH:MI:SS') AS PODate FROM PurchaseOrder;
CREATE OR REPLACE PACKAGE OrderProcessing
AS
    INVALID_PRODUCT EXCEPTION;
    NOT_ENOUGH_IN_STOCK EXCEPTION;

    PRAGMA EXCEPTION_INIT(INVALID_PRODUCT, -20001);
    PRAGMA EXCEPTION_INIT(NOT_ENOUGH_IN_STOCK, -20002);

    PROCEDURE Do1Order (I_custnum IN Customer.CustomerID%type,
                        I_prod1   IN Product.ProductID%type,
                        I_quan1   IN OrderDetails.Quantity%type,
                        I_prod2   IN Product.ProductID%type,
                        I_quan2   IN OrderDetails.Quantity%type,
                        I_paytype IN ProductOrder.PaymentType%type);
END;
/

CREATE OR REPLACE PACKAGE BODY OrderProcessing
AS
    PROCEDURE CreateProductOrder (I_custnum  IN  Customer.CustomerID%type,
                                  I_paytype  IN  ProductOrder.PaymentType%type,
                                  O_ordernum OUT ProductOrder.OrderID%type)
    AS
    BEGIN
        O_ordernum := OrderSEQ.NEXTVAL;

        INSERT INTO ProductOrder (OrderID, CustomerID, OrderDate, ShipDate, PaymentType) VALUES (O_ordernum, I_custnum, SYSDATE, NULL, I_paytype);
    END;

    PROCEDURE CreateOrderDetail (I_ordernum IN ProductOrder.OrderID%type,
                                 I_prodnum  IN Product.ProductID%type,
                                 I_quan     IN OrderDetails.Quantity%type)
    AS
        V_instock Product.QuanInStock%type;
    BEGIN
        SELECT QuanInStock INTO V_instock FROM Product WHERE ProductID = I_prodnum;

        IF V_instock < I_quan THEN
            RAISE_APPLICATION_ERROR(-20002, 'Insufficient quantity in stock.');
        END IF;

        INSERT INTO OrderDetails (OrderID, ProductID, Quantity) VALUES (I_ordernum, I_prodnum, I_quan);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20001, 'Bad product ' || I_prodnum);
    END;

    PROCEDURE CreateOrderLog (I_ordernum IN ErrorLog.OrderID%type,
                              I_custnum   IN OrderLog.CustomerID%type,
                              I_totalcost IN OrderLog.OrderTotalPrice%type)
    AS
    BEGIN
        INSERT INTO OrderLog (OrderID, OrderDateTime, CustomerID, OrderTotalPrice)
            VALUES (I_ordernum, SYSDATE, I_custnum, I_totalcost);
    END;

    PROCEDURE CreateErrorLog (I_ordernum IN ErrorLog.OrderID%type,
                              I_custnum  IN ErrorLog.CustomerID%type,
                              I_prodnum  IN ErrorLog.ProductID%type,
                              I_quan     IN ErrorLog.Quantity%type,
                              I_msg      IN ErrorLog.ErrorMessage%type)
    AS
    BEGIN
        INSERT INTO ErrorLog
            (OrderId, OrderDateTime, CustomerID, ProductID, Quantity, ErrorMessage)
                VALUES (I_ordernum, SYSDATE, I_custnum, I_prodnum, I_quan, I_msg);
    END;

    PROCEDURE Do1Order (I_custnum IN Customer.CustomerID%type,
                        I_prod1   IN Product.ProductID%type,
                        I_quan1   IN OrderDetails.Quantity%type,
                        I_prod2   IN Product.ProductID%type,
                        I_quan2   IN OrderDetails.Quantity%type,
                        I_paytype IN ProductOrder.PaymentType%type)
    AS
        V_custnum   Customer.CustomerID%type;
        V_ordernum  ProductOrder.OrderID%type;
        V_totalcost OrderLog.OrderTotalPrice%type;

        V_whichprod INTEGER;
    BEGIN
        OrderProcessing.CreateProductOrder(I_custnum, I_paytype, V_ordernum);
        COMMIT;

        SELECT CustomerID INTO V_custnum FROM Customer WHERE CustomerID = I_custnum;

        SELECT SUM(Price) INTO V_totalcost FROM Product WHERE ProductID = I_prod1 OR ProductID = I_prod2;

        OrderProcessing.CreateOrderLog(V_ordernum, I_custnum, V_totalcost);

        -- Assert that we're working with the first product
        V_whichprod := 1;

        OrderProcessing.CreateOrderDetail(V_ordernum, I_prod1, I_quan1);

        -- Assert that we're working with the second product
        V_whichprod := 2;

        OrderProcessing.CreateOrderDetail(V_ordernum, I_prod2, I_quan2);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            OrderProcessing.CreateErrorLog(V_ordernum, NULL, NULL, NULL, 'Bad Customer ' || I_custnum);
        WHEN INVALID_PRODUCT THEN
            ROLLBACK;
            OrderProcessing.CreateErrorLog(V_ordernum, V_custnum, NULL, NULL, SUBSTR(SQLERRM, 11));
        WHEN NOT_ENOUGH_IN_STOCK THEN
            ROLLBACK;
            IF V_whichprod = 1 THEN
                OrderProcessing.CreateErrorLog(V_ordernum, V_custnum, I_prod1, I_quan1, SUBSTR(SQLERRM, 11));
            ELSE
                OrderProcessing.CreateErrorLog(V_ordernum, V_custnum, I_prod2, I_quan2, SUBSTR(SQLERRM, 11));
            END IF;
    END;
END;
/

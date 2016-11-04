CREATE OR REPLACE TRIGGER CheckQuan
    AFTER UPDATE OF QuanInStock ON Product
    FOR EACH ROW
    WHEN (new.QuanInStock < old.ReorderPoint)
BEGIN
    INSERT INTO ReOrder (ProductID, ReorderQuan) VALUES (:new.ProductID, :new.ReorderQuan);
END;
/

CREATE OR REPLACE TRIGGER DoCustInvoice
    AFTER INSERT ON ProductOrder
    FOR EACH ROW
DECLARE
    V_invoicenum CustInvoice.InvoiceNo%type;
BEGIN
    V_invoicenum := InvoiceSEQ.NEXTVAL;

    INSERT INTO CustInvoice (InvoiceNo, CustNo, CustName, Street, Zip) (
        SELECT V_invoicenum AS InvoiceNo, CustomerID, FirstName || ' ' || LastName, Street, Zip FROM Customer WHERE CustomerID = :new.CustomerID
    );
END;
/

CREATE OR REPLACE TRIGGER DoPO
    AFTER INSERT ON ReOrder
    FOR EACH ROW
DECLARE
    V_PONo PurchaseOrder.PONo%type;
BEGIN
    V_PONo := 'PO' || PONoSEQ.NEXTVAL;

    INSERT INTO PurchaseOrder (PONo, ProductID, PODate) VALUES (V_PONo, :new.ProductID, :new.RequestDate);
END;
/
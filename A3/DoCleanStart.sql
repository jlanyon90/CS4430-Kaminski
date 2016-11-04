delete from Club;
delete from Supplier;
delete from Customer;
delete from Zipcode;
delete from Member;
delete from Product;
delete from PurchaseOrder;
delete from ProductOrder;
delete from OrderDetails;
start DataLoader
delete from ReOrder;
delete from OrderLog;
delete from ErrorLog;
delete from CustInvoice;
start StartSequences
execute StartUpAreaCodeFix
execute StartUpQuanCheck
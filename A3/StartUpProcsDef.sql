CREATE OR REPLACE PROCEDURE StartUpFixAreaCode AS
    CURSOR Cur_old_n IS
        SELECT * FROM (
            (SELECT TO_CHAR(CustomerID) AS ID, Phone, 'I' AS Type FROM Customer) UNION 
            (SELECT SupplierID AS ID, Phone, 'S' AS Type FROM Supplier) UNION
            (SELECT TO_CHAR(ClubID) AS ID, Phone, 'C' AS Type FROM Club)
        ) WHERE (Phone >= 4170000000 AND Phone < 4180000000) OR (Phone >= 7140000000 AND Phone < 7150000000);

    V_old_n_rec Cur_old_n%rowtype;
    V_new_n integer;
BEGIN
    OPEN Cur_old_n;

    LOOP
        FETCH Cur_old_n INTO V_old_n_rec;
        EXIT WHEN Cur_old_n%notfound;

        IF V_old_n_rec.Phone < 7140000000 THEN
            V_new_n := V_old_n_rec.Phone + 270000000;
        ELSE
            V_new_n := V_old_n_rec.Phone - 1590000000;
        END IF;

        IF V_old_n_rec.Type = 'I' THEN
            UPDATE Customer SET Phone = V_new_n WHERE CustomerID = V_old_n_rec.ID;
        ELSIF V_old_n_rec.Type = 'S' THEN
            UPDATE Supplier SET Phone = V_new_n WHERE SupplierID = V_old_n_rec.ID;
        ELSE
            UPDATE Club SET Phone = V_new_n WHERE ClubID = V_old_n_rec.ID;
        END IF;
    END LOOP;

    CLOSE Cur_old_n;
END;
/

CREATE OR REPLACE PROCEDURE StartUpQuanCheck AS
    CURSOR Cur_to_reorder IS
        SELECT ProductID FROM Product WHERE QuanInStock < 10 OR Price < 5.00;

    V_product Cur_to_reorder%rowtype;
BEGIN
    OPEN Cur_to_reorder;

    LOOP
        FETCH Cur_to_reorder INTO V_product;
        EXIT WHEN Cur_to_reorder%notfound;

        INSERT INTO ReOrder (ProductID, ReorderQuan) VALUES (V_product.ProductID, 5);
    END LOOP;

    CLOSE Cur_to_reorder;
END;
/
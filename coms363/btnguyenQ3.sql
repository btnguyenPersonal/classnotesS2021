--Author: Benjamin Nguyen
-- 3.
USE fooddb;
DROP TRIGGER IF EXISTS insert_check;
CREATE TRIGGER insert_check
AFTER INSERT
ON recipe
FOR EACH ROW
  IF ((SELECT count(recipe.fid) FROM recipe WHERE amount < 1) > 0)
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'amount must be positive';

USE fooddb;
DROP TRIGGER IF EXISTS insert_check;
create trigger insert_check on recipe
After insert, update as
begin
    if exists(SELECT * FROM recipe WHERE amount < 1)
    begin
        RAISERROR('Error: amount cannot be 0 or negative', 16,1);
        Rollback Transaction;
    end
end
go

USE fooddb;
DROP TRIGGER IF EXISTS insert_check;
delimiter //
CREATE TRIGGER INSERT CHECK BEFORE INSERT ON recipe 
FOR EACH ROW 
BEGIN 
IF recipe.fid < 1 THEN 
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'pno cannot be negative'; 
END IF; 
END;//
delimiter ;

--Author: Benjamin Nguyen
-- 3.
USE fooddb;
DROP TRIGGER IF EXISTS insert_check;
delimiter //
CREATE TRIGGER INSERT_CHECK BEFORE INSERT ON recipe 
FOR EACH ROW 
BEGIN 
 IF NEW.amount < 1 THEN 
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'amount cannot be negative'; 
END IF; 
END;//
delimiter ;

insert into recipe (amount, fid, iid) values (-10, 26, 32); 
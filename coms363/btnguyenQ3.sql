--Author: Benjamin Nguyen
-- 3.
USE fooddb;
DROP TRIGGER IF EXISTS insert_check;
delimiter //
CREATE TRIGGER insert_check
BEFORE INSERT ON recipe
FOR EACH ROW
  IF EXISTS (SELECT * FROM recipe WHERE amount > 1) THEN
    BEGIN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'amount must be positive';
    END;
  END IF; //
delimiter ;

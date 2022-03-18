DROP PROCEDURE IF EXISTS influentialUsers;
CREATE PROCEDURE influentialUsers(IN num INT, IN party VARCHAR(80))
  SELECT * FROM Users WHERE subcategory = party ORDER BY numFollowers DESC LIMIT num;

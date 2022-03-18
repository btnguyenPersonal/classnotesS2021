--Author: Benjamin Nguyen
-- 2.
USE fooddb;
DROP PROCEDURE IF EXISTS findFoodWithMeat;
delimiter //
CREATE PROCEDURE findFoodWithMeat(IN numMeatIngredients INT, IN totalgrams FLOAT)
BEGIN
  SELECT t1.fid, t1.fname, t1.totalMeatAmt FROM
  (
    SELECT food.fid, food.fname, sum(amount) AS totalMeatAmt, count(category) AS foodType
    FROM recipe
    JOIN food ON food.fid=recipe.fid
    JOIN ingredient ON ingredient.iid=recipe.iid
    WHERE ingredient.category='Meat'
    GROUP BY food.fid
    ORDER BY (food.fid) DESC
  ) AS t1
  WHERE t1.totalMeatAmt > floor(totalgrams)
  AND t1.foodType = numMeatIngredients;
END //
delimiter ;

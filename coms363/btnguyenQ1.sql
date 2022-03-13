-- 1.
-- a. returns the number of foods
SELECT COUNT(*) AS numFoods FROM food;

-- b. returns the number information about all foods and ingredients in ascending order
SELECT recipe.fid, food.fname, ingredient.iid, ingredient.iname, ingredient.caloriepergram, ingredient.category, recipe.amount
FROM food
JOIN recipe ON food.fid=recipe.fid
JOIN ingredient ON ingredient.iid=recipe.iid
ORDER BY recipe.fid;

-- c. list the values of fid and fname of all food items that each item includes both green onion and chicken as ingredients
SELECT f.fid, f.fname
FROM food f, recipe r
WHERE f.fid = r.fid
AND (r.iid=23 OR r.iid=28)
GROUP BY fid HAVING COUNT(*) > 1;

-- d. return all non-used ingredients in any recipes
SELECT ingredient.iid, ingredient.iname
FROM ingredient
WHERE ingredient.iid NOT IN
(
  SELECT recipe.iid FROM recipe
);

-- e. list all the food items in desceding order of the number of ingredients
SELECT
  recipe.fid,
  food.fname,
  count(recipe.iid) AS numIngredients,
  sum(recipe.amount) AS totalAmt
FROM recipe
JOIN food ON food.fid = recipe.fid
GROUP BY recipe.fid
ORDER BY count(recipe.iid) DESC;

-- 2.
CREATE PROCEDURE findFoodWithMeat() @numMeatIngredients INT(10), @totalgrams INT(10) AS -- todo change TO FLOAT instead
SELECT t1.fid, t1.fname, t1.totalMeatAmt FROM 
(
  SELECT food.fid, food.fname, sum(amount) AS totalMeatAmt, count(category)
  FROM recipe
  JOIN food ON food.fid=recipe.fid
  JOIN ingredient ON ingredient.iid=recipe.iid
  WHERE ingredient.category='Meat'
  GROUP BY food.fid
  ORDER BY (food.fid) DESC
) AS t1
WHERE t1.totalMeatAmt > floor(@totalgrams)
AND t1.category = @numMeatIngredients
GO;

EXEC findFoodwithMeat @numMeatIngredients = 2, @totalgrams = 100;

-- 3.

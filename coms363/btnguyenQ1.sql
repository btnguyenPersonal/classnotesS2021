--Author: Benjamin Nguyen
-- 1.a. returns the number of foods
USE fooddb;
SELECT COUNT(*) AS numFoods FROM food;

-- 1.b. returns the number information about all foods and ingredients in ascending order
USE fooddb;
SELECT recipe.fid, food.fname, ingredient.iid, ingredient.iname, ingredient.caloriepergram, ingredient.category, recipe.amount
FROM food
JOIN recipe ON food.fid=recipe.fid
JOIN ingredient ON ingredient.iid=recipe.iid
ORDER BY recipe.fid;

-- 1.c. list the values of fid and fname of all food items that each item includes both green onion and chicken as ingredients
USE fooddb;
SELECT f.fid, f.fname
FROM food f, recipe r
WHERE f.fid = r.fid
AND (r.iid=23 OR r.iid=28)
GROUP BY fid HAVING COUNT(*) > 1;

-- 1.d. return all non-used ingredients in any recipes
USE fooddb;
SELECT ingredient.iid, ingredient.iname
FROM ingredient
WHERE ingredient.iid NOT IN
(
  SELECT recipe.iid FROM recipe
);

-- 1.e. list all the food items in desceding order of the number of ingredients
USE fooddb;
SELECT
  recipe.fid,
  food.fname,
  count(recipe.iid) AS numIngredients,
  sum(recipe.amount) AS totalAmt
FROM recipe
JOIN food ON food.fid = recipe.fid
GROUP BY recipe.fid
ORDER BY count(recipe.iid) DESC;

-- a. returns the number of foods
SELECT COUNT(*) AS numFoods FROM food;

-- b. returns the number information about all foods and ingredients in ascending order
SELECT recipe.fid, food.fname, ingredient.iid, ingredient.iname, ingredient.caloriepergram, ingredient.category, recipe.amount FROM food JOIN recipe ON food.fid=recipe.fid JOIN ingredient ON ingredient.iid=recipe.iid ORDER BY recipe.fid;

-- c. list the values of fid and fname of all food items that each item includes both green onion and chicken as ingredients
SELECT f.fid, f.fname FROM food f, recipe r WHERE f.fid = r.fid AND (r.iid=23 OR r.iid=28) GROUP BY fid HAVING COUNT(*) > 1;

-- d. return all non-used ingredients in any recipes
SELECT ingredient.iid, ingredient.iname FROM ingredient WHERE ingredient.iid NOT IN (SELECT recipe.iid FROM recipe);

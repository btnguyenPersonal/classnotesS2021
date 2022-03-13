-- b. RETURNS the number OF foods
SELECT COUNT(*) AS numFoods FROM food;

-- a. RETURNS the number information about ALL foods AND ingredients IN ascending ORDER
SELECT recipe.fid, food.fname, ingredient.iid, ingredient.iname, ingredient.caloriepergram, ingredient.category, recipe.amount FROM food JOIN recipe ON food.fid=recipe.fid JOIN ingredient ON ingredient.iid=recipe.iid ORDER BY recipe.fid;

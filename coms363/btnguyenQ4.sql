--Author: Benjamin Nguyen
-- 4.a
DROP PROCEDURE IF EXISTS influentialUsers;
CREATE PROCEDURE influentialUsers(IN num INT, IN party VARCHAR(80))
  SELECT screen_name, subcategory, numFollowers FROM Users WHERE subcategory = party ORDER BY numFollowers DESC LIMIT num;

-- 4.b
DROP PROCEDURE IF EXISTS influentialTweet;
CREATE PROCEDURE influentialTweet(IN num INT, IN m INT, IN yr INT)
  SELECT texts, retweetCt, user_screen_name AS user_name, category FROM Tweets JOIN Users WHERE post_month = m AND post_year = yr ORDER BY retweetCt DESC LIMIT num;

-- Author: Benjamin Nguyen
-- 4.a

DROP PROCEDURE IF EXISTS influentialUsers;

CREATE PROCEDURE influentialUsers(IN num INT, IN party VARCHAR(80))
  SELECT screen_name, subcategory, numFollowers FROM Users WHERE subcategory = party ORDER BY numFollowers DESC LIMIT num;
  
 -- call influentialUsers(5,'GOP');

-- 4.b

DROP PROCEDURE IF EXISTS influentialTweet;
CREATE PROCEDURE influentialTweet(IN num INT, IN m INT, IN yr INT)
  SELECT texts, retweetCt, user_screen_name AS user_name, category 
  FROM Tweets left JOIN Users 
  on Tweets.user_screen_name = Users.screen_name 
  WHERE post_month = m AND post_year = yr 
  ORDER BY retweetCt DESC, user_screen_name 
  LIMIT num;
-- call influentialTweet(5,2,2016);

-- 4.c

DROP PROCEDURE IF EXISTS mostMentioned;

CREATE PROCEDURE mostMentioned(IN num INT, IN partyType varchar(80), IN m INT, IN yr INT)
  SELECT Mentions.screen_name as mentionedUser, group_concat(Distinct Users.screen_name) AS postingUsers
  FROM Mentions JOIN Tweets
  ON Mentions.tid = Tweets.tid
  JOIN Users 
  ON Tweets.user_screen_name = Users.screen_name
  WHERE post_month = m AND post_year = yr AND Users.subcategory = 'Democrat'
  group by Mentions.screen_name
  order by count(Tweets.user_screen_name) desc
  LIMIT num;
  
-- call mostMentioned(5,'Democrat',1,2016);

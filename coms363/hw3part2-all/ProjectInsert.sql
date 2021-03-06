-- use project;

-- LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL\ Server\ 8.0/Uploads/user.csv'

--     INTO TABLE Users FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
--     LINES TERMINATED BY '\n'
--     IGNORE 1 LINES
--     (screen_name,user_name,@col3,@col4,state,numFollowers,numFollowing)
--     set category = @col4, subcategory = @col3;
--         
-- LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL\ Server\ 8.0/Uploads/tweets.csv'
--     INTO TABLE Tweets FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
--     LINES TERMINATED BY '\n'
--     IGNORE 1 LINES
--     (tID,texts,retweetCt,@col4,@col5,user_screen_name)
--     SET post_day = day(str_to_date(@col5, '%Y-%m-%d %H:%i:%s')),
--     post_month = month(str_to_date(@col5, '%Y-%m-%d %H:%i:%s')),
--     post_year = year(str_to_date(@col5, '%Y-%m-%d %H:%i:%s'));
--     
-- LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL\ Server\ 8.0/Uploads/urlused.csv'
--     INTO TABLE URLs FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
--     LINES TERMINATED BY '\n'
--     IGNORE 1 LINES
--     (tid,address);
--     
-- LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL\ Server\ 8.0/Uploads/tagged.csv'
--     INTO TABLE HashTags FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
--     LINES TERMINATED BY '\n'
--     IGNORE 1 LINES
--     (tid,name);   
--     
-- LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL\ Server\ 8.0/Uploads/mentioned.csv'
--     INTO TABLE Mentions FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
--     LINES TERMINATED BY '\n'
--     IGNORE 1 LINES
--     (tid,screen_name);


use project;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/user.csv'
    INTO TABLE Users FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (screen_name,user_name,@col3,@col4,state,numFollowers,numFollowing)
    set category = @col4,
	subcategory = @col3;
        
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/tweets.csv'
    INTO TABLE Tweets FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (tID,texts,retweetCt,@col4,@col5,user_screen_name)
    SET post_day = day(str_to_date(@col5, '%Y-%m-%d %H:%i:%s')),
    post_month = month(str_to_date(@col5, '%Y-%m-%d %H:%i:%s')),
    post_year = year(str_to_date(@col5, '%Y-%m-%d %H:%i:%s'));
    
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/urlused.csv'
    INTO TABLE URLs FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (tid,address);
    
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/tagged.csv'
    INTO TABLE HashTags FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (tid,name);   
    
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/mentioned.csv'
    INTO TABLE Mentions FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (tid,screen_name);
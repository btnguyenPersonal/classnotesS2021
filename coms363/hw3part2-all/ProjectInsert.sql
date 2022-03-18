use project;

LOAD DATA LOCAL INFILE '/home/ben/git/classnotesS2021/coms363/hw3part2-all/user.csv'
    INTO TABLE Users FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (screen_name,user_name,@col3,@col4,state,numFollowers,numFollowing)
    set category = @col4, subcategory = @col3;
        
LOAD DATA LOCAL INFILE '/home/ben/git/classnotesS2021/coms363/hw3part2-all/tweets.csv'
    INTO TABLE Tweets FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (tID,texts,retweetCt,@col4,@col5,user_screen_name)
    SET post_day = day(str_to_date(@col5, '%Y-%m-%d %H:%i:%s')),
    post_month = month(str_to_date(@col5, '%Y-%m-%d %H:%i:%s')),
    post_year = year(str_to_date(@col5, '%Y-%m-%d %H:%i:%s'));
    
LOAD DATA LOCAL INFILE '/home/ben/git/classnotesS2021/coms363/hw3part2-all/urlused.csv'
    INTO TABLE URLs FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (tid,address);
    
LOAD DATA LOCAL INFILE '/home/ben/git/classnotesS2021/coms363/hw3part2-all/tagged.csv'
    INTO TABLE HashTags FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (tid,name);   
    
LOAD DATA LOCAL INFILE '/home/ben/git/classnotesS2021/coms363/hw3part2-all/mentioned.csv'
    INTO TABLE Mentions FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (tid,screen_name);

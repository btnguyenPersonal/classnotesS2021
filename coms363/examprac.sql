CREATE DATABASE ben;
USE ben;

CREATE TABLE VideoAds (
);

CREATE TABLE ThirdPartyAds (
  URL VARCHAR(255),
  avid INT,
  title VARCHAR(255),
  filename VARCHAR(255),
  OCR VARCHAR(255),
  cid INT NOT NULL,
  FOREIGN KEY (cid) REFERENCES Creatives (cid),
  PRIMARY KEY (avid)
);

CREATE TABLE YoutubeAds (
  YouTube_vid VARCHAR (255),
  avid INT,
  title VARCHAR(255),
  filename VARCHAR(255),
  OCR VARCHAR(255),
  cid INT NOT NULL,
  FOREIGN KEY (cid) REFERENCES Creatives (cid),
  PRIMARY KEY (avid)
);

CREATE TABLE Advertisers (
  aid INT,
  name VARCHAR (255),
  regulatoryID INT,
  PRIMARY KEY (aid)
);

CREATE TABLE Creatives (
  cid INT,
  endDate DATE,
  startDate DATE,
  targettedGender VARCHAR(255),
  ageRange VARCHAR(255)
  PRIMARY KEY (cid),
  aid INT NOT NULL,
  FOREIGN KEY (aid) REFERENCES Advertisers(aid);
);

CREATE TABLE Date (
  dateTime DATE,
  PRIMARY KEY (dateTime);
);

CREATE TABLE YouTubeVideos (
  ID INT,
  channel VARCHAR(255),
  PRIMARY KEY (ID)
);

CREATE TABLE AiredWith (
  ClickedOrNot BOOLEAN,
  ForHowLong INT,
  dateTime DATE,
  YoutubeId INT,
  avid INT
  FOREIGN KEY dateTime REFERENCES Date (dateTime),
  FOREIGN KEY YoutubeId REFERENCES YouTubeVideos (ID),
  FOREIGN KEY avid REFERENCES YoutubeAds (avid),
  PRIMARY KEY (dateTime, YoutubeId, avid)
);

3) 
a.
No, because the PRIMARY KEY OF food_ingredient includes the iid

b.
No they cant fit everything because IF an ingredient IS IN two different foods, it cannot hold it. An example OF this would be ROWS 1 AND 3, both have chicken AS their ingredient, because the ingredient chicken can ONLY have one OF them AS the fid IN it.

No, fid AND iid ARE IN the recipe relation, but the PRIMARY KEY has ONLY fid. Therefore, there cannot be duplicate ROWS WITH the same fid VALUE.

4)


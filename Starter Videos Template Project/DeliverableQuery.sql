USE vv44_INTRO_USERS

/*
Drop table statements
*/
DROP table usersession
DROP TABLE users
DROP TABLE socialmedia

/*
Create Table Statements
*/
CREATE TABLE users(
	username VARCHAR(20) NOT NULL PRIMARY KEY, 
	firstname VARCHAR(20) NOT NULL, 
	middlename VARCHAR(20), 
	lastname VARCHAR(20) NOT NULL,
	password VARCHAR(20) NOT NULL
)

CREATE TABLE socialmedia(
	socmediaid VARCHAR(3) NOT NULL PRIMARY KEY,
	socialmedianame VARCHAR(30) NOT NULL
)

CREATE TABLE usersession(
	sessionID INT NOT NULL IDENTITY (1,1) PRIMARY KEY, 
	socmediaid VARCHAR(3), 
	username VARCHAR(20), 
	sessiontime INT, 
	FOREIGN KEY(socmediaid) REFERENCES socialmedia,
	FOREIGN KEY(username) REFERENCES users
)	

/*
Insert Table Statements
*/
INSERT INTO users VALUES('jkc1', 'John', 'Middle', 'Carter', 'pass1')
INSERT INTO users VALUES('amo1', 'Amos', 'Carter', 'Orange', 'pass2')
INSERT INTO users VALUES('wkc1', 'Wong', 'Caleb', 'Cartel', 'pass3')
INSERT INTO users VALUES('ddj1', 'Daisy', 'Day', 'Johnson', 'pass4')
INSERT INTO users VALUES('dps1', 'Dayne', 'Pint', 'Shipper', 'pass5')

INSERT INTO socialmedia VALUES('FB', 'Facebook')
INSERT INTO socialmedia VALUES('TWT', 'Twitter')
INSERT INTO socialmedia VALUES('IG', 'Instagram')
INSERT INTO socialmedia VALUES('YT', 'YouTube')

INSERT INTO usersession VALUES('FB', 'jkc1', 256)
INSERT INTO usersession VALUES('TWT', 'amo1', 20)
INSERT INTO usersession VALUES('IG', 'wkc1', 60)
INSERT INTO usersession VALUES('YT', 'ddj1', 180)
INSERT INTO usersession VALUES('FB', 'dps1', 25)

/*
Select Table Statements
*/
SELECT * FROM users
SELECT * FROM socialmedia
SELECT * FROM usersession



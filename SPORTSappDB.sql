
CREATE DATABASE IF NOT EXISTS sports;                                               /* name of database can change */

USE sports;

DROP TABLE IF EXISTS USER;
CREATE TABLE USER (
    userId INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(20) NOT NULL,
    email VARCHAR(50) NOT NULL,                                                     /* ? unsure */
    password VARCHAR(255) NOT NULL,
    profile_img varchar(255) DEFAULT 'images/default.jpg',                          /* default image path at server side */
    score INT DEFAULT '0',
    PRIMARY KEY (`userid`),
    UNIQUE KEY email (`email`)
);

DROP TABLE IF EXISTS FRIEND;
CREATE TABLE FRIEND (
    friendId INT AUTO_INCREMENT PRIMARY KEY,
    user_1 INT,                                                                     /* name of users can be subjected to change */
    user_2 INT,                                                                     /* user_1 is YOU, user_2 is a stranger. Adding forms a relation and adds a line in this table */
    status ENUM('pending', 'accepted', 'rejected') DEFAULT 'pending',
    FOREIGN KEY (user_1) REFERENCES user(userId),
    FOREIGN KEY (user_2) REFERENCES user(userId)
);


DROP TABLE IF EXISTS LEADERBOARD;
CREATE TABLE LEADERBOARD (
    username VARCHAR(20) NOT NULL,
    score INT DEFAULT '0',
    category VARCHAR(50) NOT NULL
);
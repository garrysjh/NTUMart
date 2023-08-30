
CREATE DATABASE IF NOT EXISTS dip;                                               /* name of database can change */

USE dip;

CREATE TABLE  IF NOT EXISTS  USER (
    userID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    fullname VARCHAR(50),
    email VARCHAR(50) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    password VARCHAR(255) NOT NULL,
    address VARCHAR(100),
    profilePic varchar(255) DEFAULT 'images/default.jpg',                      /* Default path can be changed on server side */
    UNIQUE KEY email (`email`)
);

CREATE TABLE  IF NOT EXISTS INTERESTS (
    interest_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    interest_name VARCHAR(255)
);

CREATE TABLE  IF NOT EXISTS USER_INTERESTS (
    userID INT,
    interest_id INT,
    PRIMARY KEY (userID, interest_id),
    FOREIGN KEY (userID) REFERENCES USER(userID),
    FOREIGN KEY (interest_id) REFERENCES INTERESTS(interest_id)
);

CREATE TABLE  IF NOT EXISTS CHAT (
    chatID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    userID_1 INT,
    userID_2 INT,
);

CREATE TABLE  IF NOT EXISTS MESSAGE  (
    messageID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    chatID INT,
    message_text VARCHAR(255),
    timestamp DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS PRODUCT (
    productID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    sellerID INT NOT NULL,
    name VARCHAR(50),
    desc VARCHAR(250),
    price DECIMAL(6,2).
    quantity INT,
    productPic VARCHAR(255) DEFAULT 'products/',                                 /* Pathing for Product Pictures */
    category VARCHAR(50)
);

CREATE TABLE  IF NOT EXISTS SERVICE (
    serviceID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    hostID INT,
    title VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    fee DECIMAL(6,2),
    startTime TIMESTAMP,
    endTime TIMESTAMP,
    venue VARCHAR(255)
);

CREATE TABLE  IF NOT EXISTS BOOKING (
    bookingID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    userID INT NOT NULL,
    serviceID INT,
    productID INT,
    fee DECIMAL(6,2),
    bookingDate DATE
);
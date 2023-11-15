-- Create the database if it doesn't exist
DROP DATABASE IF EXISTS dip;
CREATE DATABASE IF NOT EXISTS dip; 
-- Use the 'dip' database
USE dip;
-- Create the USER table
CREATE TABLE IF NOT EXISTS USER (
    
    userID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    telegramHandle VARCHAR(50) NOT NULL, 
    fullname VARCHAR(50),
    email VARCHAR(50) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    password VARCHAR(255) NOT NULL,
    address VARCHAR(100),
    profilePic VARCHAR(255) DEFAULT 'images/default.jpg',
    UNIQUE KEY email (`email`)
);


-- Create the CHAT table
CREATE TABLE IF NOT EXISTS CHAT (
    chatID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    userID_1 INT,
    userID_2 INT
);

-- Create the MESSAGE table
CREATE TABLE IF NOT EXISTS MESSAGE  (
    messageID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    chatID INT,
    message_text VARCHAR(255),
    timestamp DATE NOT NULL
);

-- Create the PRODUCT table
CREATE TABLE IF NOT EXISTS PRODUCT (
    productID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    sellerID INT NOT NULL,
    name VARCHAR(50),
    description VARCHAR(250),
    price DECIMAL(6,2),
    quantity INT,
    productPic VARCHAR(255) DEFAULT 'products/',
    productPic2 VARCHAR(255) DEFAULT 'products/',
    productPic3 VARCHAR(255) DEFAULT 'products/',
    productPic4 VARCHAR(255) DEFAULT 'products/',
    productLikes INT DEFAULT 0, 
    date DATETIME,
    category VARCHAR(50)
);

-- Create the FAVOURITE table
-- For now it can be either "Everytime the user views a product, it increases the number of likes to show interest"
-- Or The User justs favourite an Item
CREATE TABLE IF NOT EXISTS FAVOURITE  (
    favouriteID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    userID INT NOT NULL,
    productID INT NOT NULL,
    likes INT DEFAULT 0
);

-- Create the REVIEWS table
CREATE TABLE IF NOT EXISTS REVIEWS (
    reviewID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    reviewerID INT NOT NULL,
    sellerID INT NOT NULL,
    stars ENUM('ZERO_STARS','ONE_STAR','TWO_STARS','THREE_STARS','FOUR_STARS','FIVE_STARS'),
    reviewDesc VARCHAR(255)
);

-- Create the INTEREST table
CREATE TABLE IF NOT EXISTS INTEREST (
    interestID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    userID INT NOT NULL UNIQUE,
    category1 VARCHAR(50) DEFAULT NULL,
    category2 VARCHAR(50) DEFAULT NULL,
    category3 VARCHAR(50) DEFAULT NULL,
    category4 VARCHAR(50) DEFAULT NULL,
    category5 VARCHAR(50) DEFAULT NULL
);

-- Create the SERVICE table
CREATE TABLE IF NOT EXISTS SERVICE (
    serviceID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    hostID INT,
    title VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    fee DECIMAL(6,2),
    startTime TIMESTAMP,
    endTime TIMESTAMP,
    venue VARCHAR(255)
);

-- Create the BOOKING table
CREATE TABLE IF NOT EXISTS BOOKING (
    bookingID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    userID INT NOT NULL,
    serviceID INT,
    productID INT,
    fee DECIMAL(6,2),
    bookingDate DATE
);


	-- THIS CHUNK NOT IN USE --
	-- Create the INTERESTS table
	-- CREATE TABLE IF NOT EXISTS INTERESTS (
	--     interest_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	--     interest_name VARCHAR(255)
	-- );
	
	-- -- Create the USER_INTERESTS table
	-- CREATE TABLE IF NOT EXISTS USER_INTERESTS (
	--     userID INT,
	--     interest_id INT,
	--     PRIMARY KEY (userID, interest_id),
	--     FOREIGN KEY (userID) REFERENCES USER(userID),
	--     FOREIGN KEY (interest_id) REFERENCES INTERESTS(interest_id)
	-- );

package com.ntumart.model;

public class User {
    private int userID;
    private String username;
    private String password;
    private String fullName;
    private String email;
    private String phone; // with country code
    private String address;
    private String profilePicture; // profilePicture path

    // Constructor to initialize the User object
    public User(int userID, String username, String password, String fullName, String email, String phone, String address, String profilePicture) {
        this.userID = userID;
        this.username = username;
        this.password = password;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.profilePicture = profilePicture;
    }

    // Getter for userID
    public int getUserID() {
        return userID;
    }

    // Setter for userID
    public void setUserID(int userID) {
        this.userID = userID;
    }

    // Getter for username
    public String getUsername() {
        return username;
    }

    // Setter for username
    public void setUsername(String username) {
        this.username = username;
    }

    // Getter for password
    public String getPassword() {
        return password;
    }

    // Setter for password
    public void setPassword(String password) {
        this.password = password;
    }

    // Getter for fullName
    public String getFullName() {
        return fullName;
    }

    // Setter for fullName
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    // Getter for email
    public String getEmail() {
        return email;
    }

    // Setter for email
    public void setEmail(String email) {
        this.email = email;
    }

    // Getter for phone
    public String getPhone() {
        return phone;
    }

    // Setter for phone
    public void setPhone(String phone) {
        this.phone = phone;
    }

    // Getter for address
    public String getAddress() {
        return address;
    }

    // Setter for address
    public void setAddress(String address) {
        this.address = address;
    }

    // Getter for profilePicture
    public String getProfilePicture() {
        return profilePicture;
    }

    // Setter for profilePicture
    public void setProfilePicture(String profilePicture) {
        this.profilePicture = profilePicture;
    }
}
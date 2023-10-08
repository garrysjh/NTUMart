package com.ntumart.dipapp.models;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name="user")
@Data
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "userID")
    private int userId;
    @Column(unique = true, name = "username")
    private String username;

    @Column(name="fullname")
    private String fullname;

    @Column(name="telegramHandle")
    private String telegramHandle;

    @Column(unique = true, name="email")
    private String email;

    @Column(unique = true, name="phone")
    private String phone;

    @Column(name="password")
    private String password;

    @Column(name="address")
    private String address;

    @Column(name="profilePic")
    private String profilePic;

    public User()
    {
        
    }

    public User(int id, String username, String telegramHandle , String fullname, String email, String phone, String password, String address, String profilePic) {
        this.telegramHandle = telegramHandle; 
        this.userId = id;
        this.username = username;
        this.fullname = fullname;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.address = address;
        this.profilePic = profilePic;
    }

//    public User(int id, String username, String fullname, String email, String phone, String password, String address) {
//        this.userId = id;
//        this.username = username;
//        this.fullname = fullname;
//        this.email = email;
//        this.phone = phone;
//        this.password = password;
//        this.address = address;
//        this.profilePic = "image/default.jpg";
//    }

    public int getId() {
        return userId;
    }

    public void setId(int id) {
        this.userId = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getProfilePic() {
        return profilePic;
    }

    public void setProfilePic(String profilePic) {
        this.profilePic = profilePic;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + userId +
                ", username='" + username + '\'' +
                ", fullname='" + fullname + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", password='" + password + '\'' +
                ", address='" + address + '\'' +
                ", profilePic='" + profilePic + '\'' +
                '}';
    }
}


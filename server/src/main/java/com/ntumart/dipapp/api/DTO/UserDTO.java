package com.ntumart.dipapp.api.DTO;

import com.ntumart.dipapp.models.User;
import com.ntumart.dipapp.api.service.ProductResponseService;
import com.ntumart.dipapp.models.FileData;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;

public class UserDTO {

    private String uploadDir = ".//src//main//resources//";
    private String telegramHandle; 
    private String username;
    private String fullname;
    private String email;
    private String phone;
    private String password;
    private String address;
    private FileData profilePic;


    public UserDTO(){ 

    }

    public UserDTO(User user){ 
        this.telegramHandle = user.getTelegramHandle(); 
        this.username = user.getUsername(); 
        this.fullname = user.getFullname(); 
        this.email = user.getEmail(); 
        this.phone = user.getPhone(); 
        this.address = user.getAddress(); 
        this.profilePic = this.getImageDataFromReference(uploadDir + user.getProfilePic()); 
    }
    // Getter and Setter for username
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    // Getter and Setter for fullname
    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    // Getter and Setter for email
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    // Getter and Setter for phone
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    // Getter and Setter for password
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    // Getter and Setter for address
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }


    // Getter and Setter for address
    public String getTelegramHandle() {
        return telegramHandle;
    }

    public void setTelegramHandle(String telegramHandle) {
        this.telegramHandle = telegramHandle;
    }
    // Getter and Setter for profilePic
    public FileData getProfilePic() {
        return profilePic;
    }

    public void setProfilePic(FileData profilePic) {
        this.profilePic = profilePic;
    }

    public FileData getImageDataFromReference(String filePath) {
        try {
            Path path = Paths.get(filePath);
            String fileName = path.getFileName().toString();
            String fileType = Files.probeContentType(path);
            byte[] content = Files.readAllBytes(path);

            return new FileData(fileName, fileType, content);
        } catch (IOException e) {
            e.printStackTrace(); // Handle the exception as per your application's requirements
            return null; // or throw an exception
        }
    }
}

package com.ntumart.dipapp.api.service;

import com.ntumart.dipapp.api.repository.UserRepository;
import com.ntumart.dipapp.models.User;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {
    @Autowired
    UserRepository userRepository;

public void registerUser(User user){
    userRepository.save(user);

    // Gets current UserID and Creates Image Directories
    Integer userId = user.getUserId();

    String userFolderPath = "images\\" + userId + "\\profpic";
    File userFolder = new File(userFolderPath);
    
    if (userFolder.mkdirs()) {
        // Creates File Directory returns true
        System.out.println("Directory is created");
    }
    else {
        // No Directory is created returns false
        System.out.println("Directory cannot be created");
    }


    // Create Directory for Users' Products
    String prodFolderPath = "images\\" + userId + "\\products";
    File prodImgFolder = new File(prodFolderPath);

    if (prodImgFolder.mkdirs()) {
        // Creates File Directory returns true
        System.out.println("Directory is created");
    }
    else {
        // No Directory is created returns false
        System.out.println("Directory cannot be created");
    }

}

    public int checkExistingUsername(String username){return userRepository.checkExistingUsername(username); }
    public boolean authenticate(String username, String password){return userRepository.checkAuthentication(username, password) ==1; }
    public int checkExistingMobile(String mobile){return userRepository.checkExistingMobile(mobile); }

}
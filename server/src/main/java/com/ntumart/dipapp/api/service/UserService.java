package com.ntumart.dipapp.api.service;

import com.ntumart.dipapp.api.repository.UserRepository;
import com.ntumart.dipapp.models.User;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Service;

@Service
public class UserService {
    @Autowired
    UserRepository userRepository;

//    public int registerNewUserServiceCall(String username, String fullname, String email, String phone, String password, String address, String profilePic ){
//        return userRepository.registerUser(username, fullname, email, phone, password, address, profilePic);
//    }
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

}

    public int checkExistingUsername(String username){return userRepository.checkExistingUsername(username); }

    public int checkExistingMobile(String mobile){return userRepository.checkExistingMobile(mobile); }

}

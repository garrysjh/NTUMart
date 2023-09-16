package com.ntumart.dipapp.api.service;

import com.ntumart.dipapp.api.repository.UserRepository;
import com.ntumart.dipapp.models.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {
    @Autowired
    UserRepository userRepository;

public void registerUser(User user){
    userRepository.save(user);
}

    public int checkExistingUsername(String username){return userRepository.checkExistingUsername(username); }
    public boolean authenticate(String username, String password){return userRepository.checkAuthentication(username, password) ==1; }
    public int checkExistingMobile(String mobile){return userRepository.checkExistingMobile(mobile); }

}
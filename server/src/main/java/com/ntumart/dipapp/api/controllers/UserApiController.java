package com.ntumart.dipapp.api.controllers;

import com.ntumart.dipapp.api.service.UserService;
import com.ntumart.dipapp.models.LoginRequest;
import com.ntumart.dipapp.models.User;
import net.minidev.json.JSONObject;
import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import com.ntumart.dipapp.api.service.JwtTokenService; 

@RestController
@RequestMapping("/api/v1")
public class UserApiController {
    @Autowired
    UserService userService;

    @Autowired
    JwtTokenService jwtTokenService;

    @GetMapping("/test")
    public String testEndPoint(){
        return "Test end point is working!";
    }

    @PostMapping(value = "/user/register", produces = "application/json")
    public ResponseEntity<String> registerUser(@RequestBody User user) {
        if (user == null) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("status", "error");
            jsonObject.put("message", "User is null");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(jsonObject.toString());
        }

        if (user.getProfilePic() == null) {
            user.setProfilePic("images/default.jpg");
        }

        if (userService.checkExistingUsername(user.getUsername()) > 0) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("status", "error");
            jsonObject.put("message", "Username already exists!");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(jsonObject.toString());
        }

        if (userService.checkExistingMobile(user.getPhone()) > 0) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("status", "error");
            jsonObject.put("message", "Phone already exists!");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(jsonObject.toString());
        }

        userService.registerUser(user);

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("status", "success");
        jsonObject.put("message", "User registered successfully");

        return ResponseEntity.ok(jsonObject.toString());
    }

    @PostMapping("/user/login")
    public ResponseEntity<?> authenticate(@RequestBody LoginRequest loginRequest) {
        // Authenticate the user
        boolean authenticated = userService.authenticate(loginRequest.getUsername(), loginRequest.getPassword());
        if (authenticated) {
            String token = jwtTokenService.generateToken(loginRequest.getUsername());
            Map<String, String> responseMap = new HashMap<>();
            responseMap.put("token", token);

            // Return the Map as JSON
            return ResponseEntity.ok(responseMap);
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Authentication failed");
        }
    }
}

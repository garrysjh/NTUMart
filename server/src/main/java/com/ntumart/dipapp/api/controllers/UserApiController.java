package com.ntumart.dipapp.api.controllers;

import com.ntumart.dipapp.api.service.UserService;
import com.ntumart.dipapp.models.User;
import net.minidev.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

@RestController
@RequestMapping("/api/v1")
public class UserApiController {
    @Autowired
    UserService userService;

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
}

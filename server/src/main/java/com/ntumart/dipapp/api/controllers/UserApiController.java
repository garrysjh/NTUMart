package com.ntumart.dipapp.api.controllers;

import org.springframework.http.HttpStatus;
import com.ntumart.dipapp.api.service.UserService;
import com.ntumart.dipapp.models.User;
import com.ntumart.dipapp.models.LoginRequest;
import com.ntumart.dipapp.api.service.JwtTokenService;
import net.minidev.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1")
@CrossOrigin(origins = "*")
public class UserApiController {
    @Autowired
    UserService userService;

    @Autowired
    JwtTokenService jwtTokenService;

    @GetMapping("/test")
    public String testEndPoint() {
        return "Test end point is working!";
    }

    @RequestMapping(value = "/user/register", method = RequestMethod.POST, produces = { "application/json" })
    @ResponseBody
    public String registerUser(@RequestBody User user) {
        if (user.getProfilePic() == null) {
            user.setProfilePic("images/default.jpg");
        }
        if (user == null) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("status", "error");
            jsonObject.put("message", "User is null");
            return jsonObject.toString();
        }
        // check username
        else if (userService.checkExistingUsername(user.getUsername()) > 0) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("status", "error");
            jsonObject.put("message", "Username already exists!");
            return "Username already exists!";

        }
        // check email
        else if (userService.checkExistingMobile(user.getPhone()) > 0) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("status", "error");
            jsonObject.put("message", "Phone already exists!");
            return "Mobile already exists!";

        } else {
            userService.registerUser(user);
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("status", "success");
            jsonObject.put("message", "User registered successfully");
            return "User registered successfully!";

        }
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
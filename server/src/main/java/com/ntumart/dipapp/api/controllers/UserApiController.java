package com.ntumart.dipapp.api.controllers;

import com.ntumart.dipapp.api.service.UserService;
import com.ntumart.dipapp.models.User;
import net.minidev.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1")
public class UserApiController {
    @Autowired
    UserService userService;

    @GetMapping("/test")
    public String testEndPoint(){
        return "Test end point is working!";
    }

    @RequestMapping(value = "/user/register", method = RequestMethod.POST, produces = {"application/json"})
    @ResponseBody
    public String registerUser(@RequestBody User user) {
        if (user.getProfilePic() == null){
            user.setProfilePic("images/default.jpg");
        }
        if (user == null) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("status", "error");
            jsonObject.put("message", "User is null");
            return jsonObject.toString();
        }
        //check username
        else if (userService.checkExistingUsername(user.getUsername()) > 0) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("status", "error");
            jsonObject.put("message", "Username already exists!");
            return "Username already exists!";


        }
        //check email
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
}

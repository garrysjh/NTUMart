package com.ntumart.dipapp.api.controllers;
import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.ntumart.dipapp.api.service.ProfUploadService;

import net.minidev.json.JSONObject;


@RestController
@RequestMapping("/api/v1")
public class ProfileUploadController {

    @Autowired
    ProfUploadService profUploadService;

    @PostMapping("/{userId}/update-profile-pic")
    public ResponseEntity<String> uploadImage(@PathVariable Integer userId, @RequestParam("profilePic") MultipartFile file) {
        try {
            
            profUploadService.uploadFile(userId,file);

            return ResponseEntity.ok("Image uploaded successfully!");

        } catch (Exception e) {
            e.printStackTrace();
            
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to upload image.");
            
        }
    }
}


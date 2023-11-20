package com.ntumart.dipapp.api.controllers;


import com.ntumart.dipapp.api.service.ProfUploadService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/api/v1")
public class ProfileUploadController {

  @Autowired ProfUploadService profUploadService;

  @PostMapping("/user/update-profile-pic/{userId}")
  public ResponseEntity<String> uploadImage(
      @PathVariable Integer userId, @RequestParam("profilePic") MultipartFile file) {
    try {

      profUploadService.uploadFile(userId, file);

      return ResponseEntity.ok("Image uploaded successfully!");

    } catch (Exception e) {
      e.printStackTrace();

      return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
          .body("Failed to upload image.");
    }
  }
}

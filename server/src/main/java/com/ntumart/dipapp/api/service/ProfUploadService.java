package com.ntumart.dipapp.api.service;

import com.ntumart.dipapp.api.repository.ProfUploadRepository;
import com.ntumart.dipapp.models.User;
import jakarta.persistence.EntityNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

@Service
public class ProfUploadService {

  @Autowired private ProfUploadRepository uploadRepository;

  private String uploadDir = ".//src//main//resources";

  public void uploadFile(Integer userId, MultipartFile file) throws IOException {

    // if (!file.isEmpty()) {
    byte[] fileBytes = file.getBytes();
    String fileName = StringUtils.cleanPath(file.getOriginalFilename());

    Optional<User> optionalUserProfile = uploadRepository.findById(userId);

    User userImage =
        optionalUserProfile.orElseThrow(
            () -> new EntityNotFoundException("User with ID " + userId + " not found"));

    // Renames the profile image. Helps to Override Profile Image (Naming Convention
    // can change)
    fileName = userId + "_pp.jpg";
    String dir = uploadDir + "//images//profpic//" + userId;
    Files.createDirectories(Paths.get(dir));
    Path filePath = Paths.get(dir, fileName);
    Files.write(filePath, file.getBytes());
    userImage.setProfilePic("images/profpic/" + userId + "/" + fileName);
    userImage = uploadRepository.save(userImage);

    // throw new IllegalArgumentException("Image file Uploaded");
    // }

  }
}

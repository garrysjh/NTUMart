package com.ntumart.dipapp.api.controllers;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.nio.file.Path;

@RestController
@RequestMapping("/api/v1/")
public class ImageController {

    // Use a relative path for uploadDir based on the controller location
    private final String baseUploadDir = ".\\src\\main\\resources\\images\\uploads";

    @GetMapping("/images/uploads/{directory}/{filename:.+}")
    public ResponseEntity<Resource> serveImage(@PathVariable String directory, @PathVariable String filename) throws IOException {

        Path imagePath = Path.of(baseUploadDir, directory, filename);
        System.out.println("Absolute Path: " + imagePath.toAbsolutePath());
        Resource resource = new UrlResource(imagePath.toUri());

        if (resource.exists() && resource.isReadable()) {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);

            return ResponseEntity.ok()
                    .headers(headers)
                    .body(resource);
        } else {
            System.out.println("Image not found at path: " + imagePath);
            return ResponseEntity.notFound().build();
        }
    }


    @GetMapping("/hello")
    public String sayHello() {
        System.out.print("test");
        return "Hello, World!";
    }
}

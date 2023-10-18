package com.ntumart.dipapp.api.controllers;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.ntumart.dipapp.api.repository.InterestRepository;
import com.ntumart.dipapp.api.service.InterestService;
import com.ntumart.dipapp.exceptions.EmptyFileException;
import com.ntumart.dipapp.exceptions.ProductNotFoundException;
import com.ntumart.dipapp.models.Interest;
import com.ntumart.dipapp.models.Product;

@RestController
@RequestMapping("/api/v1/user")

public class InterestController {

        @Autowired
        InterestService interestService;
        @Autowired
        InterestRepository interestRepository;

        @RequestMapping(value = "/interest", method = RequestMethod.POST, produces = {"application/json"})
        @ResponseBody
        public ResponseEntity<String> addInterest(@RequestBody Interest interest){
            try {
                interestService.addInterest(interest);
                System.out.println("Received Interest object: " + interest);
                return ResponseEntity.ok("Interest Added Successfully");
            } catch (EmptyFileException e) {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("File is empty");
            } catch (IOException e) {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error uploading the file");
            }
    }

    @GetMapping("/{userID}/interest")
    public ResponseEntity<String[]> userID(@PathVariable int userID) throws ProductNotFoundException {
        Interest interest = interestRepository.userID(userID);
        
        if (interest == null) {
            return ResponseEntity.notFound().build();
        }
        
        return ResponseEntity.ok(interest.toArray());
    }
        
}


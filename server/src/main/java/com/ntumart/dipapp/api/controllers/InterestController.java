package com.ntumart.dipapp.api.controllers;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

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
        public ResponseEntity<String> addInterest(@ModelAttribute Interest interest){
            try {
                interestService.addInterest(interest);
                return ResponseEntity.ok("Interest Added Successfully");
            } catch (EmptyFileException e) {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("File is empty");
            } catch (IOException e) {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error uploading the file");
            }
    }

    @GetMapping("/{userID}/interest")
    public ResponseEntity<List<Object>> userID(@PathVariable int userID) throws ProductNotFoundException {
        List<Object> interest = interestRepository.userID(userID);
        
        if (interest.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        
        return ResponseEntity.ok(interest);
    }
        
}


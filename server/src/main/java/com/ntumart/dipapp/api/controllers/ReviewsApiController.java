package com.ntumart.dipapp.api.controllers;


import com.ntumart.dipapp.api.service.ReviewsService;
import com.ntumart.dipapp.exceptions.ProductNotFoundException;
import com.ntumart.dipapp.models.Reviews;

import java.io.IOException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/api/v1/reviews")

public class ReviewsApiController {

    @Autowired
    // ProductService productService;
    ReviewsService reviewsService;

    // When Testing for Postman
    // Add another line in Body>Raw for "sellerID"
    @RequestMapping(value = "/add/{reviewerId}", method = RequestMethod.POST, produces = { "application/json" })
    @ResponseBody
    public ResponseEntity<String> addReview(@RequestBody Reviews reviews, @PathVariable Integer reviewerId) {
        try {
            reviewsService.addReview(reviews, reviewerId);

            return ResponseEntity.ok("Review Added Successfully");

        } catch (Exception e) {
            return ResponseEntity.ok("None Added");
        }
        
    }

    // Update base on ReviewID, as User One to Many Reviews
    @PostMapping("/update/{reviewId}")
    public ResponseEntity<String> updateReview(@RequestBody Reviews reviews, @PathVariable Integer reviewId) {
        try {

            reviewsService.updateReview(reviews, reviewId);

            return ResponseEntity.ok("Review Updated Successfully");
        } catch (Exception e) {
            return ResponseEntity.ok("Not Updated");
        }
    }

    // Delete base on ReviewID, as User One to Many Reviews
    @PostMapping("/delete/{reviewId}")
    public ResponseEntity<String> deleteReview(@RequestBody Reviews reviews, @PathVariable Integer reviewId) {
        try {

            reviewsService.deleteReview(reviews, reviewId);

            return ResponseEntity.ok("Review Deleted Successfully");
        } catch (Exception e) {
            return ResponseEntity.ok("Not Deleted");
        }
    }
    
}

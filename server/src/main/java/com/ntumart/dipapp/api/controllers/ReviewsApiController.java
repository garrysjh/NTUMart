package com.ntumart.dipapp.api.controllers;

import com.ntumart.dipapp.api.service.JwtTokenService;
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

    @Autowired
    JwtTokenService jwtTokenService;

    // When Testing for Postman
    // Add another line in Body>Raw for "sellerID"
    @RequestMapping(value = "/add", method = RequestMethod.POST, produces = { "application/json" })
    @ResponseBody
    public ResponseEntity<String> addReview(@RequestBody Reviews reviews,
            @RequestHeader("Authorization") String token) {
        try {

            int reviewerId = jwtTokenService.getUserID(token);
            if (reviewerId == -1) { // user is not found
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body("User not found");
            }
            reviewsService.addReview(reviews, reviewerId);

            return ResponseEntity.ok("Review Added Successfully");

        } catch (Exception e) {
            return ResponseEntity.ok("None Added");
        }

    }

    // Update base on ReviewID, as User One to Many Reviews
    // Add "reviewID" to request body when testing
    @PostMapping("/update")
    public ResponseEntity<String> updateReview(@RequestBody Reviews reviews,
            @RequestHeader("Authorization") String token) {
        try {
            int reviewerId = jwtTokenService.getUserID(token);
            if (reviewerId == -1) { // user is not found
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body("User not found");
            }
            if (reviewerId != reviewsService.getReviewerIDFromReviewID(reviews)) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body("Not authorised to edit review");
            }
            reviewsService.updateReview(reviews, reviews.getReviewID());

            return ResponseEntity.ok("Review Updated Successfully");
        } catch (Exception e) {
            return ResponseEntity.ok("Not Updated");
        }
    }

    // Delete base on ReviewID, as User One to Many Reviews
    // Add "reviewID" to request body when testing
    @PostMapping("/delete")
    public ResponseEntity<String> deleteReview(@RequestBody Reviews reviews,
            @RequestHeader("Authorization") String token) {
        try {
            int reviewerId = jwtTokenService.getUserID(token);
            if (reviewerId == -1) { // user is not found
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body("User not found");
            }
            if (reviewerId != reviewsService.getReviewerIDFromReviewID(reviews)) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body("Not authorised to edit review");
            }
            reviewsService.deleteReview(reviews, reviews.getReviewID());

            return ResponseEntity.ok("Review Deleted Successfully");
        } catch (Exception e) {
            return ResponseEntity.ok("Not Deleted");
        }
    }
}

package com.ntumart.dipapp.api.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ntumart.dipapp.api.repository.ReviewsRepository;
import com.ntumart.dipapp.exceptions.ReviewsNotFoundException;
import com.ntumart.dipapp.models.Product;
import com.ntumart.dipapp.models.Reviews;
import com.ntumart.dipapp.models.User;
import com.ntumart.dipapp.models.Reviews.StarRating;


@Service
public class ReviewsService {
    
    @Autowired
    ReviewsRepository reviewsRepository;

    public void addReview(Reviews reviews, Integer reviewerId){

        reviews.setReviewerID(reviewerId);

        reviewsRepository.save(reviews);
    }


    // For Testing
    // Just add "stars" and "reviewDesc" in Postman
    public void updateReview (Reviews reviews, Integer reviewId) throws ReviewsNotFoundException {

        // Finding the row based on ReviewID
        Optional<Reviews> existingReviewOptional = reviewsRepository.findById(reviewId);

        if (existingReviewOptional.isPresent()) {
            //  If the review with the given reviewId exists, update its StarRating and ReviewDescription
            Reviews existingReview = existingReviewOptional.get();

            existingReview.setReviewID(existingReview.getReviewID());
            existingReview.setSellerID(existingReview.getSellerId());
            existingReview.setStars(reviews.getStars());
            existingReview.setReviewDesc(reviews.getReviewDesc());
            
            reviewsRepository.save(existingReview);
        } else {
            throw new ReviewsNotFoundException("Review not found with id: " + reviewId);
        }

    }

    public void deleteReview (Reviews reviews, Integer reviewId) {
        reviews.setId(reviewId);
        reviewsRepository.delete(reviews);
    }
}

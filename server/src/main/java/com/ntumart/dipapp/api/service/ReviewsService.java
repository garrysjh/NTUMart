package com.ntumart.dipapp.api.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ntumart.dipapp.api.repository.ReviewsRepository;
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

}

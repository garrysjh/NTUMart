package com.ntumart.dipapp.api.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ntumart.dipapp.models.Interest;
import com.ntumart.dipapp.models.Product;
import com.ntumart.dipapp.api.repository.InterestRepository;
import com.ntumart.dipapp.exceptions.EmptyFileException;
import com.ntumart.dipapp.exceptions.ProductNotFoundException;

import java.io.IOException;

@Service

public class InterestService {

    @Autowired
    InterestRepository interestRepository;

    public void addInterest(Interest interest) 
        throws IOException, EmptyFileException {
        interestRepository.save(interest);
    }


    public Interest getInterestByUserID(int userID) throws ProductNotFoundException {
        Interest interest = interestRepository.getInterestByUserID(userID);
        if(interest == null) {
            throw new ProductNotFoundException("Interest Not Found");
        }
        return interest;
    }

    public void updateInterest(int userID, String category1, String category2, String category3, String category4, String category5) throws IOException, ProductNotFoundException {
        Interest interest = getInterestByUserID(userID);
        interest.setCategory1(category1);
        interest.setCategory2(category2);
        interest.setCategory3(category3);
        interest.setCategory4(category4);
        interest.setCategory5(category5);
        interestRepository.save(interest);
    }
}

package com.ntumart.dipapp.api.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ntumart.dipapp.models.Interest;

import com.ntumart.dipapp.api.repository.InterestRepository;
import com.ntumart.dipapp.exceptions.EmptyFileException;

import java.io.IOException;

@Service

public class InterestService {

    @Autowired
    InterestRepository interestRepository;

    public void addInterest(Interest interest) 
        throws IOException, EmptyFileException {
        interestRepository.save(interest);
    }
    
    
}

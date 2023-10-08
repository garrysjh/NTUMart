package com.ntumart.dipapp.api.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ntumart.dipapp.api.repository.ListingRepository;
import com.ntumart.dipapp.models.Product;

@Service
public class ListingService {
    @Autowired
    ListingRepository listingRepository;

    public List<Product> getAllProducts() {
        return listingRepository.findAll();
    }
}

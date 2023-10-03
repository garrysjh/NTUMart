package com.ntumart.dipapp.api.controllers;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestParam;
import com.ntumart.dipapp.models.Product;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Optional; 
import com.ntumart.dipapp.api.repository.ListingRepository;
import com.ntumart.dipapp.api.repository.UserRepository;
import com.ntumart.dipapp.api.service.ListingService;
import com.ntumart.dipapp.api.DTO.ProductFilterRequestDTO; 
import org.springframework.web.bind.annotation.ModelAttribute;

@RestController
@RequestMapping("/api/v1")
public class ListingController {
    @Autowired
    ListingRepository listingRepository;

    @Autowired
    ListingService listingService;

    @Autowired
    UserRepository userRepository;


    @PostMapping("/product/listing")
    public ResponseEntity<List<Product>> listAllProducts(@ModelAttribute ProductFilterRequestDTO request,
            @RequestParam(required = false) String sortBy) {
        LocalDateTime startDateTime = (request.getStartDate() != null) ? LocalDateTime.parse(request.getStartDate())
                : null;
        LocalDateTime endDateTime = (request.getEndDate() != null) ? LocalDateTime.parse(request.getEndDate()) : null;
                
        List<Product> products = listingRepository.getProducts(
                 (request != null ? request.getName()
                        : null) , 
                startDateTime,
                endDateTime,
                (request != null && request.getName() != null) ? userRepository.getUserId(request.getName())
                        : null,
                (request != null) ? request.getCategory() : null);

        if (sortBy != null) {
            products = listingService.sortProducts(products, sortBy);
        }
        return ResponseEntity.ok(products);
    }
}
package com.ntumart.dipapp.api.controllers;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestParam;
import com.ntumart.dipapp.models.Product;
import java.time.LocalDateTime;
import com.ntumart.dipapp.api.repository.ListingRepository;
import com.ntumart.dipapp.api.repository.UserRepository;
import com.ntumart.dipapp.api.service.ListingService;
import com.ntumart.dipapp.api.DTO.ProductFilterRequestDTO; 
import org.springframework.web.bind.annotation.ModelAttribute;
import com.ntumart.dipapp.models.ProductResponse;

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
    public ResponseEntity<List<ProductResponse>> listAllProducts(
            @ModelAttribute ProductFilterRequestDTO request,
            @RequestParam(required = false) String sortBy
    ) {
        LocalDateTime startDateTime = (request.getStartDate() != null) ? LocalDateTime.parse(request.getStartDate())
                : null;
        LocalDateTime endDateTime = (request.getEndDate() != null) ? LocalDateTime.parse(request.getEndDate()) : null;

        String name = (request != null) ? request.getName() : null;
        Integer userId = (name != null) ? userRepository.getUserId(name) : null;

        List<Product> products = listingRepository.getProducts(
                name,
                startDateTime,
                endDateTime,
                userId,
                (request != null) ? request.getCategory() : null
        );

        if (sortBy != null) {
            products = listingService.sortProducts(products, sortBy);
        }
        List<ProductResponse> productResponses = new ArrayList<>();
        
        for (Product product : products) {
            productResponses.add(new ProductResponse(product));
        }
    
        return ResponseEntity.ok(productResponses);
    }
}
package com.ntumart.dipapp.api.controllers;

import java.util.List;

import org.hibernate.mapping.Collection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ntumart.dipapp.models.Product;
import java.util.ArrayList;
import com.ntumart.dipapp.api.service.ListingService;

@RestController
@RequestMapping("/api/v1")
public class ListingController {
    @Autowired
    ListingService listingService;
     @GetMapping("/listing")
    public ResponseEntity<List<Product>> listAllProducts(){
        List<Product> products = listingService.getAllProducts();
        return ResponseEntity.ok(products);
    }
}

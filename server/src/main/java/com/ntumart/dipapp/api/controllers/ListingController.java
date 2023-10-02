package com.ntumart.dipapp.api.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestParam;
import com.ntumart.dipapp.models.Product;
import java.util.ArrayList;

import com.ntumart.dipapp.api.repository.ListingRepository;
import com.ntumart.dipapp.api.service.ListingService;
import com.ntumart.dipapp.models.Product;

@RestController
@RequestMapping("/api/v1")
public class ListingController {
    @Autowired

    ListingService listingService;
    @GetMapping("/product/listing")
    public ResponseEntity<List<Product>> listFilteredAndSortedProducts(
            @RequestParam(required = false) String sortBy)  {

        List<Product> products = listingService.getFilteredAndSortedProducts(sortBy);

    @Autowired

    ListingRepository listingRepository;

     @GetMapping("/product/listing")
    public ResponseEntity<List<Object>> listAllProducts(){
        List<Object> products = listingService.getNameANDDescriptionANDProductLikes();
        return ResponseEntity.ok(products);
    }
}

package com.ntumart.dipapp.api.controllers;

import com.ntumart.dipapp.api.DTO.ProductFilterRequestDTO;
import com.ntumart.dipapp.api.repository.ListingRepository;
import com.ntumart.dipapp.api.repository.UserRepository;
import com.ntumart.dipapp.api.service.ListingService;
import com.ntumart.dipapp.api.service.ProductResponseService;
import com.ntumart.dipapp.models.Product;
import com.ntumart.dipapp.models.ProductResponse;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1")
public class ListingController {
  @Autowired ListingRepository listingRepository;

  @Autowired ListingService listingService;

  @Autowired UserRepository userRepository;

  @Autowired ProductResponseService productResponseService;

  @PostMapping("/product/listing")
  public ResponseEntity<List<ProductResponse>> listAllProducts(
      @ModelAttribute ProductFilterRequestDTO request,
      @RequestParam(required = false) String sortBy,
      @RequestParam(name = "sortOrder", defaultValue = "asc") String sortOrder,
      @RequestParam(required = false) String searchTerm,
      @RequestParam(required = false) Integer sellerID) {
    LocalDateTime startDateTime =
        (request.getStartDate() != null) ? LocalDateTime.parse(request.getStartDate()) : null;
    LocalDateTime endDateTime =
        (request.getEndDate() != null) ? LocalDateTime.parse(request.getEndDate()) : null;

    String name = (request != null) ? request.getName() : null;
    Integer userId = (name != null) ? request.getUserId() : null;
    System.out.println(name);

    List<Product> products =
        listingRepository.getProducts(
            name,
            startDateTime,
            endDateTime,
            userId,
            (request != null
                    && request.getCategories() != null
                    && request.getCategories().length >= 1)
                ? request.getCategories()[0]
                : null,
            (request != null
                    && request.getCategories() != null
                    && request.getCategories().length >= 2)
                ? request.getCategories()[1]
                : null,
            (request != null
                    && request.getCategories() != null
                    && request.getCategories().length >= 3)
                ? request.getCategories()[2]
                : null,
            (request != null
                    && request.getCategories() != null
                    && request.getCategories().length >= 4)
                ? request.getCategories()[3]
                : null,
            (request != null
                    && request.getCategories() != null
                    && request.getCategories().length == 5)
                ? request.getCategories()[4]
                : null);

    // For Searching for Product Name
    if (searchTerm != null) {
      products = listingService.searchProduct(searchTerm);
    }

    if (sellerID != null) {
      products = listingService.searchProduct(sellerID);
    }

    if (sortBy != null) {
      products = listingService.sortProducts(products, sortBy);
    }
    List<ProductResponse> productResponses = new ArrayList<>();

    if ("asc".equalsIgnoreCase(sortOrder)) {

      for (Product product : products) {
        productResponses.add(productResponseService.getProductResponse(product));
      }

    } else if ("desc".equalsIgnoreCase(sortOrder)) {

      for (Product product : products) {
        productResponses.add(productResponseService.getProductResponse(product));
      }

      Collections.reverse(productResponses);
    }

    return ResponseEntity.ok(productResponses);
  }
}

package com.ntumart.dipapp.api.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Comparator;
import com.ntumart.dipapp.api.repository.ListingRepository;
import com.ntumart.dipapp.models.Product;

@Service
public class ListingService {
    @Autowired
    ListingRepository listingRepository;

    public List<Product> getAllProducts() {
        return listingRepository.findAll();
    }
    public List<Product> sortProducts(List<Product> products, String sortBy) { 
        if (sortBy != null) {
            switch (sortBy) {
                case "name":
                    products.sort(Comparator.comparing(Product::getName, String.CASE_INSENSITIVE_ORDER));
                    break;
                case "price":
                    products.sort(Comparator.comparing(Product::getPrice));
                    break;
                case "date":
                    products.sort(Comparator.comparing(Product::getDate));
                    break;
                case "category":
                    products.sort(Comparator.comparing(Product::getCategory, String.CASE_INSENSITIVE_ORDER));
                    break;
                // Add more cases as needed for different sorting criteria
                // Add Case Insensitive to those that get String data
                default:
                    // Handle unknown sortBy parameter
                    throw new IllegalArgumentException("Invalid sortBy parameter");
            }
        }

        return products;
    }
}


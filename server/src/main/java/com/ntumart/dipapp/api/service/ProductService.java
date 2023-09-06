package com.ntumart.dipapp.api.service;

import com.ntumart.dipapp.api.repository.ProductRepository;

import com.ntumart.dipapp.models.Product;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;

@Service

public class ProductService {
    
    @Autowired
    ProductRepository productRepository;

    public void addProduct(Product product){
        productRepository.save(product);
    }

    // public int checkQuantity(int quantity){return productRepository.checkExistingQuantity(quantity); }

}

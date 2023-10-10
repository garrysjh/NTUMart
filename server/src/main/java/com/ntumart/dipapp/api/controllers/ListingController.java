package com.ntumart.dipapp.api.controllers;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.ntumart.dipapp.models.Product;
import com.ntumart.dipapp.models.ProductResponse;
import java.time.LocalDateTime;
import com.ntumart.dipapp.api.repository.ListingRepository;
import com.ntumart.dipapp.api.repository.UserRepository;
import com.ntumart.dipapp.api.service.ListingService;
import com.ntumart.dipapp.api.service.ProductResponseService;
import com.ntumart.dipapp.api.DTO.ProductFilterRequestDTO;

@RestController
@RequestMapping("/api/v1")
public class ListingController {
    @Autowired
    ListingRepository listingRepository;

    @Autowired
    ListingService listingService;

    @Autowired
    UserRepository userRepository;
    
    @Autowired
    ProductResponseService productResponseService;

//    @GetMapping("/all")
//    public List<Product> getAllProducts() {
////        List<Product> products = listingService.getAllProducts();
//        List<ProductDTO> productDTOs = new ArrayList<>();
//
//        for (Product product : products) {
//            ProductDTO productDTO = new ProductDTO(product);
//
//            // Convert image paths to byte arrays
//            productDTO.setProductImage(convertImagePathToByteArray(product.getProductPic()));
//            productDTO.setProductImage2(convertImagePathToByteArray(product.getProductPic2()));
//            productDTO.setProductImage3(convertImagePathToByteArray(product.getProductPic3()));
//            productDTO.setProductImage4(convertImagePathToByteArray(product.getProductPic4()));
//
//            productDTOs.add(productDTO);
//        }
//
//        return productDTOs;
//    }
//
//    private byte[] convertImagePathToByteArray(String imagePath) {
//        try {
//            File file = ResourceUtils.getFile("classpath:" + imagePath);
//            return Files.readAllBytes(file.toPath());
//        } catch (IOException e) {
//            // Handle the exception (e.g., log it or return a default image)
//            e.printStackTrace();
//            return new byte[0]; // Return an empty byte array or a default image byte array
//        }
//    }
//}

    @PostMapping("/product/listing")
    public ResponseEntity<List<ProductResponse>> listAllProducts(
            @ModelAttribute ProductFilterRequestDTO request,
            @RequestParam(required = false) String sortBy
    ) {
        LocalDateTime startDateTime = (request.getStartDate() != null) ? LocalDateTime.parse(request.getStartDate())
                : null;
        LocalDateTime endDateTime = (request.getEndDate() != null) ? LocalDateTime.parse(request.getEndDate()) : null;

        String name = (request != null) ? request.getName() : null;
        Integer userId = (name != null) ? userRepository.getUserID(name) : null;

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
            productResponses.add(productResponseService.getProductResponse(product));
        }
    
        return ResponseEntity.ok(productResponses);
    }


}
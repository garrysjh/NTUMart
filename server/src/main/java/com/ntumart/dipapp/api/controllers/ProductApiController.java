package com.ntumart.dipapp.api.controllers;

import com.ntumart.dipapp.api.DTO.ProductDTO;
import com.ntumart.dipapp.api.service.JwtTokenService;
import com.ntumart.dipapp.api.service.ProductService;
import com.ntumart.dipapp.exceptions.EmptyFileException;
import com.ntumart.dipapp.exceptions.ProductNotFoundException;
import com.ntumart.dipapp.models.Product;
import java.io.IOException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/api/v1/product")

public class ProductApiController {

    @Autowired
    ProductService productService;

    @Autowired
    JwtTokenService jwtTokenService;

    @RequestMapping(value = "/add", method = RequestMethod.POST, produces = { "application/json" })
    @ResponseBody
    public ResponseEntity<String> addProduct(@RequestHeader("Authorization") String token,@ModelAttribute Product product, @ModelAttribute ProductDTO productDTO,
            @RequestParam("productPicture") MultipartFile productPicture,
            @RequestParam("productPicture2") MultipartFile productPicture2,
            @RequestParam("productPicture3") MultipartFile productPicture3,
            @RequestParam("productPicture4") MultipartFile productPicture4) {
        try {
            if (jwtTokenService.getUserID(token) == -1) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body("Invalid token");
            }
            if (product.getSellerID() != jwtTokenService.getUserID(token)) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body("Not update this product");
            }
            productService.addProduct(product, productDTO, productPicture, productPicture2, productPicture3,
                    productPicture4);
            return ResponseEntity.ok("Product Successfully");
        } catch (EmptyFileException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("File is empty");
        } catch (IOException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error uploading the file");
        }
    }

    @GetMapping("/{productID}")
    public ResponseEntity<Product> getProductById(@PathVariable int productID) throws ProductNotFoundException {
        Product product = productService.getProductById(productID);
        return ResponseEntity.ok(product);
    }

    // WITH DTO
    @PostMapping("/update/{productID}")
    public ResponseEntity<String> updateProduct(
            @RequestHeader("Authorization") String token,
            @PathVariable("productID") int productID,
            @ModelAttribute ProductDTO productDTO,
            @RequestParam(value = "productPicture") MultipartFile productPicture,
            @RequestParam(value = "productPicture2") MultipartFile productPicture2,
            @RequestParam(value = "productPicture3") MultipartFile productPicture3,
            @RequestParam(value = "productPicture4") MultipartFile productPicture4)
            throws IOException, ProductNotFoundException {
        try {
            Product product = productService.getProductById(productID);
            if (jwtTokenService.getUserID(token) == -1) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body("Invalid token");
            }
            if (product.getSellerID() != jwtTokenService.getUserID(token)) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body("Not update this product");
            }
            productService.updateProduct(productID, productDTO, productPicture, productPicture2, productPicture3,
                    productPicture4);
            return ResponseEntity.ok("Product updated successfully");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Product not deleted. \n " + e.toString());
        }
    }

    @DeleteMapping("/delete/{productID}")
    public ResponseEntity<String> deleteProduct(@RequestHeader("Authorization") String token,
            @PathVariable("productID") int productID) throws IOException, ProductNotFoundException {
        try {
            Product product = productService.getProductById(productID);
            if (jwtTokenService.getUserID(token) == -1) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body("Invalid token");
            }
            if (product.getSellerID() != jwtTokenService.getUserID(token)) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body("Not authorised to delete");

            }
            productService.deleteProduct(productID);
            return ResponseEntity.ok("Product deleted successfully");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Product not deleted. \n " + e.toString());
        }

    }
}

package com.ntumart.dipapp.api.controllers;

import com.ntumart.dipapp.api.DTO.ProductDTO;
import com.ntumart.dipapp.api.service.ProductResponseService;
import com.ntumart.dipapp.api.service.ProductService;
import com.ntumart.dipapp.exceptions.EmptyFileException;
import com.ntumart.dipapp.exceptions.ProductNotFoundException;
import com.ntumart.dipapp.models.Product;
import com.ntumart.dipapp.models.ProductResponse;
import java.io.IOException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.mock.web.MockMultipartFile;

@RestController
@RequestMapping("/api/v1/product")

public class ProductApiController {

    @Autowired
    ProductService productService;

    @Autowired
    ProductResponseService productResponseService;

    @RequestMapping(value = "/add", method = RequestMethod.POST, produces = { "application/json" })
    @ResponseBody
    public ResponseEntity<String> addProduct(@ModelAttribute Product product, @ModelAttribute ProductDTO productDTO,
                                             @RequestParam("productPicture") MultipartFile productPicture,
                                             @RequestParam(name = "productPicture2", required = false) MultipartFile productPicture2,
                                             @RequestParam(name = "productPicture3", required = false) MultipartFile productPicture3,
                                             @RequestParam(name = "productPicture4", required = false) MultipartFile productPicture4) {
        try {
            productService.addProduct(product, productDTO, productPicture,
                    productPicture2 != null ? productPicture2 : new MockMultipartFile("empty", new byte[0]),
                    productPicture3 != null ? productPicture3 : new MockMultipartFile("empty", new byte[0]),
                    productPicture4 != null ? productPicture4 : new MockMultipartFile("empty", new byte[0]));
            return ResponseEntity.ok("Product Successfully");
        } catch (EmptyFileException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("File is empty");
        } catch (IOException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error uploading the file");
        }
    }

    @GetMapping("/{productID}")
    public ResponseEntity<ProductResponse> getProductById(@PathVariable int productID) throws ProductNotFoundException {
        Product product = productService.getProductById(productID);
        ProductResponse productResponse = productResponseService.getProductResponse(product); 
        return ResponseEntity.ok(productResponse);
    }

    //WITH DTO
    @PostMapping("/update/{productID}")
    public ResponseEntity<String> updateProduct(
            @PathVariable("productID") int productID,
            @ModelAttribute ProductDTO productDTO,
            @RequestParam(value = "productPicture") MultipartFile productPicture,
            @RequestParam(value = "productPicture2") MultipartFile productPicture2,
            @RequestParam(value = "productPicture3") MultipartFile productPicture3,
            @RequestParam(value = "productPicture4") MultipartFile productPicture4) throws IOException, ProductNotFoundException {
        productService.updateProduct(productID, productDTO, productPicture, productPicture2, productPicture3, productPicture4);
        return ResponseEntity.ok("Product updated successfully");
    }

    //INCREASE ProductLikes
    @PutMapping("/{productID}/uplike")
    public ResponseEntity<Product> incrementProductLikes(@PathVariable int productID) throws ProductNotFoundException {
        Product updatedLikes = productService.incrementProductLikes(productID);
        return ResponseEntity.ok(updatedLikes);
    }

    //DECREASE PRODUCTLIKES
    @PutMapping("/{productID}/downlike")
    public ResponseEntity<Product> decrementProductLikes(@PathVariable int productID) throws ProductNotFoundException {
        Product updatedLikes = productService.decrementProductLikes(productID);
        return ResponseEntity.ok(updatedLikes);
    }

    @DeleteMapping("/delete/{productID}")
    public ResponseEntity<String> deleteProduct(@PathVariable("productID") int productID) throws IOException, ProductNotFoundException{
            productService.deleteProduct(productID);
            return ResponseEntity.ok("Product deleted successfully");
        
    
    }
}

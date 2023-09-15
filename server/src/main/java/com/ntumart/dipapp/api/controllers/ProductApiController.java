package com.ntumart.dipapp.api.controllers;

import com.ntumart.dipapp.api.DTO.ProductDTO;
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
@RequestMapping("/api/v1")

public class ProductApiController {
    
    @Autowired
    ProductService productService;

    @RequestMapping(value = "/add/product", method = RequestMethod.POST, produces = {"application/json"})
    @ResponseBody
    public ResponseEntity<String> addProduct(@ModelAttribute ProductDTO productDTO, @RequestParam("productPic") MultipartFile data) {
        try {
            productService.addProduct(productDTO, data);
            return ResponseEntity.ok("Product Successfully");
        }
        catch (EmptyFileException e){ 
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("File is empty");
        } catch (IOException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error uploading the file");
        } 
        // if (product.getProductPic() == null){
        //     product.setProductPic("images/default.jpg");
        // }
        
        // if (product== null) {
        //     JSONObject jsonObject = new JSONObject();
        //     jsonObject.put("status", "error");
        //     jsonObject.put("message", "User is null");
        //     return jsonObject.toString();
        // }
        // // //check username
        // // else if (ProductService.checkExistingUsername(product.getUsername()) > 0) {
        // //     JSONObject jsonObject = new JSONObject();
        // //     jsonObject.put("status", "error");
        // //     jsonObject.put("message", "Username already exists!");
        // //     return "Username already exists!";


        // // }
        // // //check email
        // // else if (ProductService.checkExistingMobile(product.getPhone()) > 0) {
        // //     JSONObject jsonObject = new JSONObject();
        // //     jsonObject.put("status", "error");
        // //     jsonObject.put("message", "Phone already exists!");
        // //     return "Mobile already exists!";

        // // } 
        // else {
        //     productService.addProduct(product);
        //     JSONObject jsonObject = new JSONObject();
        //     jsonObject.put("status", "success");
        //     jsonObject.put("message", "Product Successfully Added");
        //     return "Product Successfully Added";

        // }
    }

    @GetMapping("/{productID}")
    public ResponseEntity<Product> getProductById(@PathVariable int productID) throws ProductNotFoundException{
        Product product = productService.getProductById(productID);
        return ResponseEntity.ok(product);
    }

    @PostMapping("/{productID}")
    public ResponseEntity<String> updateProduct(
            @PathVariable int productID,
            @RequestBody Product updatedProduct,
            @RequestParam("productPic") MultipartFile data) throws IOException, ProductNotFoundException {
        productService.updateProduct(productID, updatedProduct,data);
        return ResponseEntity.ok("Product updated successfully");
    }

    

}

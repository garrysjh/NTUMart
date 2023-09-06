package com.ntumart.dipapp.api.controllers;

import com.ntumart.dipapp.api.service.ProductService;

import com.ntumart.dipapp.models.Product;
import net.minidev.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1")

public class ProductApiController {
    
    @Autowired
    ProductService productService;

    @RequestMapping(value = "/add/product", method = RequestMethod.POST, produces = {"application/json"})
    @ResponseBody
    public String addProduct(@RequestBody Product product) {
        if (product.getProductPic() == null){
            product.setProductPic("images/default.jpg");
        }
        
        if (product== null) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("status", "error");
            jsonObject.put("message", "User is null");
            return jsonObject.toString();
        }
        // //check username
        // else if (ProductService.checkExistingUsername(product.getUsername()) > 0) {
        //     JSONObject jsonObject = new JSONObject();
        //     jsonObject.put("status", "error");
        //     jsonObject.put("message", "Username already exists!");
        //     return "Username already exists!";


        // }
        // //check email
        // else if (ProductService.checkExistingMobile(product.getPhone()) > 0) {
        //     JSONObject jsonObject = new JSONObject();
        //     jsonObject.put("status", "error");
        //     jsonObject.put("message", "Phone already exists!");
        //     return "Mobile already exists!";

        // } 
        else {
            productService.addProduct(product);
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("status", "success");
            jsonObject.put("message", "Product Successfully Added");
            return "Product Successfully Added";

        }
    }

}

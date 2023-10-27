package com.ntumart.dipapp.api.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;

import com.ntumart.dipapp.models.FileData;
import com.ntumart.dipapp.models.Product;
import com.ntumart.dipapp.models.ProductResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service; 
import java.util.List;
import java.time.LocalDateTime;
import com.ntumart.dipapp.api.repository.UserRepository;

@Service
public class ProductResponseService {

    @Autowired
    UserRepository userRepository;


    private String parentDir = ".//src//main//resources//";
    public ProductResponse getProductResponse(Product product) {
        int productId = product.getProductID();
        String sellerName = userRepository.getNameFromID(product.getSellerID());
        String productName = product.getName();
        String description = product.getDescription();
        double price = product.getPrice();
        int quantity = product.getQuantity();
        List<FileData> productImages = new ArrayList<>();
        
        
        if (product.getProductPic() != null) {
            productImages.add(getImageDataFromReference(parentDir + product.getProductPic()));
        }

        if (product.getProductPic2() != null) {
            productImages.add(getImageDataFromReference(parentDir +product.getProductPic2()));
        }

        if (product.getProductPic3() != null) {
            productImages.add(getImageDataFromReference(parentDir +product.getProductPic3()));
        }

        if (product.getProductPic4() != null) {
            productImages.add(getImageDataFromReference(parentDir +product.getProductPic4()));
        }

        int productLikes = product.getProductLikes();
        LocalDateTime date = product.getDate();
        String category = product.getCategory();

        return new ProductResponse(productId, sellerName, productName, description, price, quantity, productImages, productLikes, date,
                category);
    }

    public FileData getImageDataFromReference(String filePath) {
        try {
            Path path = Paths.get(filePath);
            String fileName = path.getFileName().toString();
            String fileType = Files.probeContentType(path);
            byte[] content = Files.readAllBytes(path);

            return new FileData(fileName, fileType, content);
        } catch (IOException e) {
            e.printStackTrace(); // Handle the exception as per your application's requirements
            return null; // or throw an exception
        }
    }
}

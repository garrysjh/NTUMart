package com.ntumart.dipapp.models;

import org.springframework.beans.factory.annotation.Autowired;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import org.springframework.web.multipart.MultipartFile;
import com.ntumart.dipapp.api.repository.UserRepository;
import com.ntumart.dipapp.models.FileData;
import com.ntumart.dipapp.models.Product;

public class ProductResponse {

    @Autowired
    private UserRepository userRepository;

    private String sellerName;
    private String name;
    private String description;
    private double price;
    private int quantity;
    private List<FileData> productImages;

    private int productLikes;
    private LocalDateTime date;
    private String category;

    public ProductResponse(Product product) {

        this.sellerName = userRepository.getNameFromID(product.getSellerID());
        this.name = product.getName();
        this.description = product.getDescription();
        this.price = product.getPrice();
        this.quantity = product.getQuantity();
        this.productImages = new ArrayList<>();

        if (product.getProductPic() != null) {
            this.productImages.add(getImageDataFromReference(product.getProductPic()));
        }

        if (product.getProductPic2() != null) {
            this.productImages.add(getImageDataFromReference(product.getProductPic2()));
        }

        if (product.getProductPic3() != null) {
            this.productImages.add(getImageDataFromReference(product.getProductPic3()));
        }

        if (product.getProductPic4() != null) {
            this.productImages.add(getImageDataFromReference(product.getProductPic4()));
        }
        
        this.productLikes = product.getProductLikes();
        this.date = product.getDate();
        this.category = product.getCategory();
    }

    public String getSellerName() {
        return sellerName;
    }

    public void setSellerName(String sellerName) {
        this.sellerName = sellerName;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public List<FileData> getProductImages(){ 
        return productImages; 
    }

    public void setProductImages(List<FileData> productImages){ 
        this.productImages = productImages; 
    }
    public int getProductLikes() {
        return productLikes;
    }

    public void setProductLikes(int productLikes) {
        this.productLikes = productLikes;
    }

    public LocalDateTime getDate() {
        return date;
    }

    public void setDate(LocalDateTime date) {
        this.date = date;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
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

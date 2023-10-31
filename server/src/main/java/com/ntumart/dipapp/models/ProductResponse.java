package com.ntumart.dipapp.models;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.time.LocalDateTime;

public class ProductResponse {
    private int productId;
    private String sellerName;
    private String productName;
    private String description;
    private double price;
    private int quantity;
    private List<FileData> productImages;

    private int productLikes;
    private LocalDateTime date;
    private String category;

    public ProductResponse(int productId, String sellerName, String productName, String description, double price, int quantity,
            List<FileData> productImages, int productLikes, LocalDateTime time, String category) {
        this.productId = productId;
        this.sellerName = sellerName;
        this.productName = productName;
        this.description = description;
        this.price = price;
        this.quantity = quantity;
        this.productImages = productImages;
        this.productLikes = productLikes;
        this.date = time;
        this.category = category;
    }

    public String getSellerName() {
        return sellerName;
    }

    public void setSellerName(String sellerName) {
        this.sellerName = sellerName;
    }

    public String getProductName() {
        return productName;
    }

    public void setName(String productName) {
        this.productName = productName;
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

    public List<FileData> getProductImages() {
        return productImages;
    }

    public void setProductImages(List<FileData> productImages) {
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

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }
}

package com.ntumart.dipapp.api.DTO;

import java.util.Date;

public class ProductDTO {
    
    private int sellerID;
    private int productID;
    private String name;
    private String description;
    private double price;
    private int quantity;
    private int productLikes;
    private Date date;
    private String category;
    
    public ProductDTO() {

    }

    public ProductDTO(int sellerID, int productID, String name, String description, double price, int quantity, int productLikes, Date date, String category) {
        this.sellerID = sellerID; 
        this.productID = productID;
        this.name = name;
        this.description = description;
        this.price = price;
        this.quantity = quantity;
        this.productLikes = productLikes;
        this.date = date;
        this.category = category;
    } 
    public int getSellerID() {
        return sellerID;
    }

    public void setSellerID(int sellerID) {
        this.sellerID = sellerID;
    }


    public int getProductID() {
        return productID;
    }

    public void setProductId(int productID) {
        this.productID = productID;
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

    public int setProductLikes() {
        return productLikes;
    }

    public void getProductLikes(int productLikes) {
        this.productLikes = productLikes;
    }

    public Date date() {
        return date;
    }

    public void getDate(Date date) {
        this.date = date;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }
}

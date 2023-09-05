package com.ntumart.model;

public class Product {
    private long productID;
    private long sellerID;
    private String name;
    private String description;
    private float price;
    private int quantity;
    private String imagePath;
    private Category category;
    
    public Product(long productID, long sellerID, String name, String description, float price, int quantity, String imagePath, Category category) {
        this.productID = productID;
        this.sellerID = sellerID;
        this.name = name;
        this.description = description;
        this.price = price;
        this.quantity = quantity;
        this.imagePath = imagePath;
        this.category = category;
    }
    // Getter for productID
    public long getProductID() {
        return productID;
    }

    // Setter for productID
    public void setProductID(long productID) {
        this.productID = productID;
    }

    // Getter for sellerID
    public long getSellerID() {
        return sellerID;
    }

    // Setter for sellerID
    public void setSellerID(long sellerID) {
        this.sellerID = sellerID;
    }

    // Getter for name
    public String getName() {
        return name;
    }

    // Setter for name
    public void setName(String name) {
        this.name = name;
    }

    // Getter for description
    public String getDescription() {
        return description;
    }

    // Setter for description
    public void setDescription(String description) {
        this.description = description;
    }

    // Getter for price
    public float getPrice() {
        return price;
    }

    // Setter for price
    public void setPrice(float price) {
        this.price = price;
    }

    // Getter for quantity
    public int getQuantity() {
        return quantity;
    }

    // Setter for quantity
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    // Getter for imagePath
    public String getImagePath() {
        return imagePath;
    }

    // Setter for imagePath
    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    // Getter for category
    public Category getCategory() {
        return category;
    }

    // Setter for category
    public void setCategory(Category category) {
        this.category = category;
    }
}

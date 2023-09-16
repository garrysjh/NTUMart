package com.ntumart.dipapp.models;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name="product")
@Data

public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "productID")
    private int productID;

    // @Id
    // @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "sellerID")
    private int sellerID;

    @Column(name = "name")
    private String name;

    @Column(name="description")
    private String description;

    @Column(name="price")
    private double price;

    @Column(name="quantity")
    private int quantity;

    @Column(name="productPic")
    private String productPic;

    @Column(name="category")
    private String category;

    @Lob
    @Column(nullable = false)
    private byte[] data;

    //No Argument Constructor
    public Product() {
        // Default Constructor with no parameters
    }
    public Product(int id, int id2, String name, String description, double price, int quantity, byte[] data, String productPic, String category) {
        this.productID = id;
        this.sellerID = id2;
        this.name = name;
        this.description = description;
        this.price = price;
        this.quantity = quantity;
        this.data = data;
        this.productPic = productPic;
        this.category = category;
    }

    public Product(String name, String description) {
        this.name = name;
        this.description = description;
    }

    public int productID() {
        return productID;
    }

    public void setId(int id) {
        this.productID = id;
    }

    public int sellerId() {
        return sellerID;
    }

    public void setId2(int id2) {
        this.sellerID = id2;
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

    public byte[] getData() {
        return data;
    }

    public void setData(byte[] data) {
        this.data = data;
    }

    public String getProductPic() {
        return productPic;
    }

    public void setProductPic(String productPic) {
        this.productPic = productPic;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    
    // @Override
    // public String toString() {
    //     return "Product{" +
    //             "productID=" + productID +
    //             ", sellerID='" + sellerID + '\'' +
    //             ", name='" + name + '\'' +
    //             ", description='" + description + '\'' +
    //             ", price='" + price + '\'' +
    //             ", quantity='" + quantity + '\'' +
    //             ", productPic='" + productPic + '\'' +
    //             ", category='" + category + '\'' +
    //             '}';
    // }
    @Override
    public String toString() {
        return "Product{" +
                "productID=" + productID +
                ", sellerID='" + sellerID + '\'' +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", price='" + price + '\'' +
                ", quantity='" + quantity + '\'' +
                ", data='" + data + '\'' +
                ", productPic='" + productPic + '\'' +
                ", category='" + category + '\'' +
                '}';
    }

    
}

package com.ntumart.dipapp.models;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;

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

    @Column(name="productPic2")
    private String productPic2;

    @Column(name="productPic3")
    private String productPic3;

    @Column(name="productPic4")
    private String productPic4;

    @Column(name="productLikes")
    private int productLikes;

    @Column(name="date")
    private LocalDateTime date;

    @Column(name="category")
    private String category;


    //No Argument Constructor
    public Product() {
        // Default Constructor with no parameters
    }
    public Product(int productID, int sellerID, String name, String description, double price, int quantity, String productPic, String productPic2, String productPic3, String productPic4, int productLikes, LocalDateTime date, String category) {
        this.productID = productID;
        this.sellerID = sellerID;
        this.name = name;
        this.description = description;
        this.price = price;
        this.quantity = quantity; 
        this.productPic = productPic;
        this.productPic2 = productPic2;
        this.productPic3 = productPic3;
        this.productPic4 = productPic4;
        this.productLikes = productLikes;
        this.date = date;
        this.category = category;
    }

    // public Product(String name, String description) {
    //     this.name = name;
    //     this.description = description;
    // }

    public int getProductID() {
        return productID;
    }

    public void setId(int id) {
        this.productID = id;
    }

    public int getSellerID() {
        return sellerID;
    }

    public void setSellerID(int sellerID) {
        this.sellerID = sellerID;
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

   
    public String getProductPic() {
        return productPic;
    }

    public void setProductPic(String productPic) {
        this.productPic = productPic;
    }

    public String getProductPic2() {
        return productPic2;
    }

    public void setProductPic2(String productPic2) {
        this.productPic2 = productPic2;
    }
    
    public String getProductPic3() {
        return productPic3;
    }

    public void setProductPic3(String productPic3) {
        this.productPic3 = productPic3;
    }

    public String getProductPic4() {
        return productPic4;
    }

    public void setProductPic4(String productPic4) {
        this.productPic4 = productPic4;
    }

    public int setProductLikes() {
        return productLikes;
    }

    public void getProductLikes(int productLikes) {
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
                ", productPic='" + productPic + '\'' +
                ", productPic2='" + productPic2 + '\'' +
                ", productPic3='" + productPic3 + '\'' +
                ", productPic4='" + productPic4 + '\'' +
                ", productLikes='" + productLikes + '\'' +
                ", date='" + date + '\'' +
                ", category='" + category + '\'' +
                '}';
    }

    
}

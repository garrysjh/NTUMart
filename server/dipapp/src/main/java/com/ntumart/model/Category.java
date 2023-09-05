package com.ntumart.model;

import java.util.HashMap;
import java.util.Map;

public class Category {
    private int categoryID; 
    private String categoryName; 
    private static final Map<String, Integer> categoryNameToIDMap = new HashMap<>();

    // Define constants for predefined category names
    // This ensutes that the categories are defined correctly 
    public static final String MEN_FASHION = "Men's Fashion";
    public static final String WOMEN_FASHION = "Women's Fashion";
    public static final String BOOKS_NOTES = "Books and Notes";

    static {
        categoryNameToIDMap.put(MEN_FASHION, 1);
        categoryNameToIDMap.put(WOMEN_FASHION, 2);
        categoryNameToIDMap.put(BOOKS_NOTES, 3);
    }

    public Category(String categoryName) {
        this.categoryName = categoryName;
        this.categoryID = getCategoryIDForName(categoryName);
    }

    private int getCategoryIDForName(String categoryName) {
        Integer categoryID = categoryNameToIDMap.get(categoryName);
        return categoryID != null ? categoryID : -1; // Return -1 for unknown category
    }

    // Getters and setters for categoryID and categoryName

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
    /* 
    for debugging
    public static void main(String[] args) {
        // Create Category instances using the predefined category names
        Category category1 = new Category(MEN_FASHION);
        Category category2 = new Category(WOMEN_FASHION);
        Category category3 = new Category(BOOKS_NOTES);

        System.out.println(category1.getCategoryID());    // Output: 1
        System.out.println(category2.getCategoryID());    // Output: 2
        System.out.println(category3.getCategoryID());    // Output: 3
    }*/
   

}

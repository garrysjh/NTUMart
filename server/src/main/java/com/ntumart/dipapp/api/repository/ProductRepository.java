package com.ntumart.dipapp.api.repository;

import com.ntumart.dipapp.models.Product;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository

public interface ProductRepository extends JpaRepository<Product, Integer> {

    @Transactional
    @Modifying
    @Query(value = "INSERT INTO PRODUCT(:sellerID, :name, :description, :price, :quantity, :data, :productPic, :productPic2, :productPic3, :productPic4, :date, :category)", nativeQuery = true)
    int addProduct(@Param("sellerID") int sellerID, @Param("name") String name,
            @Param("description") String description,
            @Param("price") double price,
            @Param("quantity") int quantity,
            @Param("productPic") String productPic,
            @Param("productPic2") String productPic2,
            @Param("productPic3") String productPic3,
            @Param("productPic4") String productPic4,
            @Param("date") LocalDateTime date,
            @Param("category") String category);

    @Query(value = "SELECT * FROM PRODUCT WHERE productID = :productID", nativeQuery = true)
    int getProductById(@Param("productID") Integer productID);

    @Query(value = "UPDATE product SET sellerID = :sellerID, name = :name , description = :description , price = :price , quantity = :quantity , data = :data ,  productPic = :productPic , productPic2 = :productPic2 , productPic3 = :productPic3 , productPic4 = :productPic4 , date = :date, category = :category", nativeQuery = true)
    int updateProduct(
            @Param("sellerID") int sellerID, 
            @Param("name") String name,
            @Param("description") String description,
            @Param("price") double price,
            @Param("quantity") int quantity,
            @Param("productPic") String productPic,
            @Param("productPic2") String productPic2,
            @Param("productPic3") String productPic3,
            @Param("productPic4") String productPic4,
            @Param("date") LocalDateTime date,
            @Param("category") String category);

    @Query(value = "UPDATE PRODUCT SET productLikes = :productLikes + 1 WHERE productID = :productID", nativeQuery = true)
    int incrementProductLikes(@Param("productID") Integer productID);

    @Query(value = "UPDATE PRODUCT SET productLikes = :productLikes - 1 WHERE productID = :productID", nativeQuery = true)
    int decrementProductLikes(@Param("productID") Integer productID);

    @Query(value = "DELETE FROM product WHERE productID = :productID", nativeQuery = true)
    int deleteProduct(@Param("productID") Integer productID);
        
}

package com.ntumart.dipapp.api.repository;

import com.ntumart.dipapp.models.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository

public interface ProductRepository extends JpaRepository<Product, Integer > {
    
    @Transactional
    @Modifying
    @Query(value="INSERT INTO PRODUCT(:name, :description, :price, :quantity, :data, :productPic, :category)", nativeQuery = true)
    int addProduct(@Param("name") String name,
                     @Param("description") String description,
                     @Param("price") double price,
                     @Param("quantity") int quantity,
                     @Param("data") byte data,
                     @Param("productPic") String productPic,
                     @Param("category") String category);

    @Query(value="SELECT * FROM PRODUCT WHERE productID = :productID", nativeQuery = true)
    int getProductById(@Param("productID") Integer productID);

    @Query(value="UPDATE product SET name = :name , description = :description , price = :price , quantity = :quantity , data = :data ,  productPic = :productPic , category = :category", nativeQuery = true)
    int updateProduct(@Param("name") String name,
                     @Param("description") String description,
                     @Param("price") double price,
                     @Param("quantity") int quantity,
                     @Param("data") byte data,
                     @Param("productPic") String productPic,
                     @Param("category") String category);
                    

    // @Query(value = "select count(quantity) from product where quantity=:quantity", nativeQuery = true)
    // int checkExistingQuantity(int quantity);

    // @Query(value = "select count(phone) from user where phone=:phone", nativeQuery = true)
    // int checkExistingMobile(String phone);
}

package com.ntumart.dipapp.api.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.ntumart.dipapp.models.Product;

import jakarta.transaction.Transactional;

public interface ListingRepository extends JpaRepository<Product, Long> {

  @Transactional
  @Modifying

  @Query(value = "SELECT name, description, price, quantity, productPic, productLikes  FROM PRODUCT", nativeQuery = true)

  public List<Object> getNameANDDescriptionANDProductLikes();

  // @Query("SELECT u FROM User u WHERE u.age > :age")
  // List<User> findUsersByAgeGreaterThan(@Param("age") int age);

}

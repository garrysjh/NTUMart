package com.ntumart.dipapp.api.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.ntumart.dipapp.models.Product;

public interface ListingRepository extends JpaRepository<Product, Long>{

    @Query(value="SELECT name, description FROM PRODUCT", nativeQuery = true)
    
    List<Product> findAll(@Param("name") String name,
                          @Param("description") String description);

    // @Query("SELECT u FROM User u WHERE u.age > :age")
    // List<User> findUsersByAgeGreaterThan(@Param("age") int age);
    
}

package com.ntumart.dipapp.api.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.ntumart.dipapp.models.Product;

import jakarta.transaction.Transactional;

public interface ListingRepository extends JpaRepository<Product, Long> {
  @Query(value = "SELECT name, description, price, quantity, productPic1, productPic2, productPic3, productPic4 , productLikes, category "
      +
      "FROM PRODUCT " +
      "WHERE (:name is null OR name LIKE CONCAT('%', :name, '%')) " +
      "  AND (:description is null OR description LIKE CONCAT('%', :name, '%')) " +
      "  AND (:date is null OR date >= :startDate) " +
      "  AND (:date is null OR date <= :endDate)" +
      "  AND (:userId is null OR userID = :userId)"
      + "  AND (:category is null OR category = :category)", nativeQuery = true)
  public List<Product> getProducts(
      @Param(value = "name") String name,
      @Param(value = "startDate") LocalDateTime startDate,
      @Param(value = "endDate") LocalDateTime endDate,
      @Param(value = "userId") int userId,
      @Param(value = "category") String category);
}

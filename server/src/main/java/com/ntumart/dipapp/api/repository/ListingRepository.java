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
  @Query(value = "SELECT *  "
      +
      "FROM PRODUCT " +
      "WHERE (:name is null OR name LIKE CONCAT('%', :name, '%')) " +
      "  OR (:name is null OR description LIKE CONCAT('%', :name, '%')) " +
      "  AND (:startDate is null OR date >= :startDate) " +
      "  AND (:endDate is null OR date <= :endDate)" +
      "  AND (:sellerID is null OR sellerID = :sellerID)"
      + "  AND (:category is null OR category = :category)", nativeQuery = true)
  public List<Product> getProducts(
      @Param(value = "name") String name,
      @Param(value = "startDate") LocalDateTime startDate,
      @Param(value = "endDate") LocalDateTime endDate,
      @Param(value = "sellerID") Integer sellerID,
      @Param(value = "category") String category);
}

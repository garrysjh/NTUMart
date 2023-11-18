package com.ntumart.dipapp.api.repository;

import java.time.LocalDateTime;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import com.ntumart.dipapp.models.Product;

public interface ListingRepository extends JpaRepository<Product, Integer> {

  @Query(value = "SELECT * FROM PRODUCT WHERE sellerID = :sellerID", nativeQuery = true)
  public List<Product> getProductsByID(@Param("sellerID") int sellerID);

  @Query(value = "SELECT * FROM PRODUCT WHERE name LIKE CONCAT ('%', :name, '%')", nativeQuery = true)
  public List<Product> getProductsBySearch(@Param("name") String name);

  @Query(value = "SELECT * " +
      "FROM PRODUCT " +
      "WHERE ((:name is null OR name LIKE CONCAT('%', :name, '%')) " +
      "  OR (:name is null OR description LIKE CONCAT('%', :name, '%'))) " +
      "  AND (:startDate is null OR date >= :startDate) " +
      "  AND (:endDate is null OR date <= :endDate) " +
      "  AND (:sellerID is null OR sellerID = :sellerID) " +
      "  AND (:category1 is null OR category = :category1) " +
      "UNION " +
      "SELECT * " +
      "FROM PRODUCT " +
      "WHERE ((:name is null OR name LIKE CONCAT('%', :name, '%')) " +
      "  OR (:name is null OR description LIKE CONCAT('%', :name, '%'))) " +
      "  AND (:startDate is null OR date >= :startDate) " +
      "  AND (:endDate is null OR date <= :endDate) " +
      "  AND (:sellerID is null OR sellerID = :sellerID) " +
      "  AND ( category = :category2) " +
      "UNION " +
      "SELECT * " +
      "FROM PRODUCT " +
      "WHERE ((:name is null OR name LIKE CONCAT('%', :name, '%')) " +
      "  OR (:name is null OR description LIKE CONCAT('%', :name, '%'))) " +
      "  AND (:startDate is null OR date >= :startDate) " +
      "  AND (:endDate is null OR date <= :endDate) " +
      "  AND (:sellerID is null OR sellerID = :sellerID) " +
      "  AND (category = :category3) " +
      "UNION " +
      "SELECT * " +
      "FROM PRODUCT " +
      "WHERE ((:name is null OR name LIKE CONCAT('%', :name, '%')) " +
      "  OR (:name is null OR description LIKE CONCAT('%', :name, '%'))) " +
      "  AND (:startDate is null OR date >= :startDate) " +
      "  AND (:endDate is null OR date <= :endDate) " +
      "  AND (:sellerID is null OR sellerID = :sellerID) " +
      "  AND (category = :category4) " +
      "UNION " +
      "SELECT * " +
      "FROM PRODUCT " +
      "WHERE ((:name is null OR name LIKE CONCAT('%', :name, '%')) " +
      "  OR (:name is null OR description LIKE CONCAT('%', :name, '%'))) " +
      "  AND (:startDate is null OR date >= :startDate) " +
      "  AND (:endDate is null OR date <= :endDate) " +
      "  AND (:sellerID is null OR sellerID = :sellerID) " +
      "  AND ( category = :category5) ", nativeQuery = true)
  public List<Product> getProducts(
      @Param(value = "name") String name,
      @Param(value = "startDate") LocalDateTime startDate,
      @Param(value = "endDate") LocalDateTime endDate,
      @Param(value = "sellerID") Integer sellerID,
      @Param(value = "category1") String category1,
      @Param(value = "category2") String category2,
      @Param(value = "category3") String category3,
      @Param(value = "category4") String category4,
      @Param(value = "category5") String category5);
} 

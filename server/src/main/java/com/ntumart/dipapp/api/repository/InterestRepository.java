package com.ntumart.dipapp.api.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.ntumart.dipapp.models.Interest;

@Repository

public interface InterestRepository extends JpaRepository<Interest, Integer>{
    
    @Transactional
    @Modifying
    // INSERTING
    @Query(value = "INSERT INTO INTEREST(:userID, :category1, :category2, :category3, :category4, :category5)", nativeQuery = true)
    int addInterest(@Param("userID") int userID,
                    @Param("category1") String category1,
                    @Param("category2") String category2,
                    @Param("category3") String category3,
                    @Param("category4") String category4,
                    @Param("category5") String category5);

    // MAPPING 2 DIFFERENT TABLE USING SAME VARIABLE
    @Query(value = "SELECT * FROM INTEREST WHERE INTEREST.userID = :userID limit 1", nativeQuery = true)
    Interest userID(int userID);
}

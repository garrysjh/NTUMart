package com.ntumart.dipapp.api.repository;

import com.ntumart.dipapp.models.Reviews;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface ReviewsRepository extends JpaRepository<Reviews, Integer> {

    @Transactional
    @Modifying
    @Query(value = "INSERT INTO REVIEWS(:reviewerID, :sellerID, :stars, :reviewDesc)", nativeQuery = true)
    int addReview(@Param("reviewerID") int reviewerID,
            @Param("sellerID") int sellerID,
            @Param("stars") String stars,
            @Param("reviewDesc") String reviewDesc);
}
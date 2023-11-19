package com.ntumart.dipapp.api.repository;

import com.ntumart.dipapp.models.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface ProfUploadRepository extends JpaRepository<User, Integer> {

  @Transactional
  @Modifying
  @Query(value = "SELECT * FROM USER WHERE userId = :userId", nativeQuery = true)
  int findUser(@Param("userId") Integer userId);

  @Query(value = "UPDATE user SET profile_pic = :profilePic", nativeQuery = true)
  int updateProfilePicByUsername(@Param("profilePic") String profilePic);
}

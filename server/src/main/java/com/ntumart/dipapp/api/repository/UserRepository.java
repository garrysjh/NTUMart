package com.ntumart.dipapp.api.repository;

import com.ntumart.dipapp.models.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {

    @Transactional
    @Modifying
    @Query(value = "INSERT INTO USER(:username, :fullname, :email, :phone, :password, :address, :profilePic)", nativeQuery = true)
    int registerUser(@Param("username") String username,
            @Param("fullname") String fullname,
            @Param("email") String email,
            @Param("phone") String phone,
            @Param("password") String password,
            @Param("address") String address,
            @Param("profilePic") String profilePic);

    @Query(value = "select count(username) from user where username=:username", nativeQuery = true)
    int checkExistingUsername(String username);

    @Query(value = "SELECT COUNT(*) FROM user WHERE username = :username AND password = :password", nativeQuery = true)
    int checkAuthentication(String username, String password);

    @Query(value = "select count(phone) from user where phone=:phone", nativeQuery = true)
    int checkExistingMobile(String phone);

    @Query(value = "select userID from user where username=:username", nativeQuery = true)
    int getUserID(String username);

    @Query(value = "select username from user where userID=:userID", nativeQuery = true)
    String getNameFromID(int userID);

}
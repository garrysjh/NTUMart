package com.ntumart.dipapp.api.service;

import com.ntumart.dipapp.api.configuration.JwtConfig;
import com.ntumart.dipapp.api.repository.UserRepository;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import java.security.Key;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class JwtTokenService {
  private static final Logger logger = LoggerFactory.getLogger(JwtTokenService.class);
  @Autowired private JwtConfig jwtConfig;

  @Autowired private UserRepository userRepository;

  public String generateToken(String username) {
    Key secretKey = jwtConfig.secretKey();
    Map<String, Object> claims = new HashMap<>();
    claims.put("sub", username);
    claims.put("id", userRepository.getUserID(username));
    claims.put("created", new Date());
    return Jwts.builder()
        .setClaims(claims)
        .setExpiration(new Date(System.currentTimeMillis() + jwtConfig.getJwtExpiration()))
        .signWith(secretKey, SignatureAlgorithm.HS256)
        .compact();
  }

  public boolean validateToken(String token) {
    try {
      Jwts.parserBuilder().setSigningKey(jwtConfig.secretKey()).build().parseClaimsJws(token);
      return true;
    } catch (Exception e) {
      return false;
    }
  }

  public int getUserID(String token) {
    if (validateToken(token) == false) {
      logger.info("INVALID TOKEN");
      return -1;
    }

    // If the token is valid, extract the user ID and return it
    Claims claims =
        Jwts.parserBuilder()
            .setSigningKey(jwtConfig.secretKey())
            .build()
            .parseClaimsJws(token)
            .getBody();

    // user is "sub"
    String username = claims.get("sub", String.class);

    // logger.info("Username: {}", username); for testing
    return userRepository.getUserID(username);
  }
}

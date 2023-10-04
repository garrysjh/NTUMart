package com.ntumart.dipapp.api.service;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import io.jsonwebtoken.Claims;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ntumart.dipapp.api.configuration.JwtConfig;
import java.security.Key;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import com.ntumart.dipapp.api.repository.UserRepository;

@Service
public class JwtTokenService {
    @Autowired
    private JwtConfig jwtConfig;

    @Autowired
    private UserRepository userRepository;

    public String generateToken(String username) {
        Key secretKey = jwtConfig.secretKey();
        Map<String, Object> claims = new HashMap<>();
        claims.put("sub", username);
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
        if (!validateToken(token)) {
            return -1; // Assuming RuntimeException is appropriate for your use case
        }

        // If the token is valid, extract the user ID and return it
        Claims claims = Jwts.parserBuilder()
                .setSigningKey(jwtConfig.secretKey())
                .build()
                .parseClaimsJws(token)
                .getBody();

        // user is "sub"
        String username = claims.get("sub", String.class);
        return userRepository.getUserID(username);

    }

}

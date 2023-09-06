package com.ntumart.dipapp.api.configuration; 

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;

import java.security.Key;

@Configuration
public class JwtConfig {

    @Value("${jwt.secret}")
    private String jwtSecret;

    @Value("${jwt.expiration}")
    private long jwtExpiration;

    @Bean
    public Key secretKey() {
        return Keys.hmacShaKeyFor(jwtSecret.getBytes());
    }

    public String getJwtSecret() {
        return jwtSecret;
    }

    public long getJwtExpiration() {
        return jwtExpiration;
    }
}
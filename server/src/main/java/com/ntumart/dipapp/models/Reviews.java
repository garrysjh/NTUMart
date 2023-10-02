package com.ntumart.dipapp.models;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name="reviews")
@Data

public class Reviews {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "reviewID")
    private int reviewID;

    @Column(name = "reviewerID")
    private int reviewerID;
    // @Id
    // @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "sellerID")
    private int sellerID;

    @Enumerated(EnumType.STRING)
    @Column(name = "stars")
    private StarRating stars;

    @Column(name="reviewDesc")
    private String reviewDesc;

    public enum StarRating {
        ONE_STAR,
        TWO_STARS,
        THREE_STARS,
        FOUR_STARS,
        FIVE_STARS
    }


    //No Argument Constructor
    public Reviews() {
        // Default Constructor with no parameters
    }
    public Reviews(int id, int reviewerID, int sellerID, StarRating stars, String reviewDesc) {
        this.reviewID = id;
        this.reviewerID = reviewerID;
        this.sellerID = sellerID;
        this.stars = stars;
        this.reviewDesc = reviewDesc;
    }

    public int getId() {
        return reviewID;
    }

    public void setId(int id) {
        this.reviewID = id;
    }

    public int getReviewerID() {
        return reviewerID;
    }

    public void setReviewerID(int reviewerID) {
        this.reviewerID = reviewerID;
    }

    public int getSellerId() {
        return sellerID;
    }

    public void setSellerID(int sellerID) {
        this.sellerID = sellerID;
    }

    public StarRating getStars() {
        return stars;
    }

    public void setStars(StarRating stars) {
        this.stars = stars;
    }

    public String getReviewDesc() {
        return reviewDesc;
    }

    public void setReviewDesc(String reviewDesc) {
        this.reviewDesc = reviewDesc;
    }

    
  @Override
    public String toString() {
        return "Reviews{" +
                "reviewID=" + reviewID +
                ", reviewerID='" + reviewerID + '\'' +
                ", sellerID='" + sellerID + '\'' +
                ", stars='" + stars + '\'' +
                ", reviewDesc='" + reviewDesc + '\'' +
                '}';
    }
    
}

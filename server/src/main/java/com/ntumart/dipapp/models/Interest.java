package com.ntumart.dipapp.models;

import jakarta.persistence.*;

import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name="interest")
@Data

public class Interest {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "interestID")
    private int interestID;

    @Column(name = "userID", unique = true)
    private int userID;

    @Column(name = "category1")
    private String category1;

    @Column(name = "category2")
    private String category2;

    @Column(name = "category3")
    private String category3;

    @Column(name = "category4")
    private String category4;

    @Column(name = "category5")
    private String category5;

    public Interest() {
        //Default Contructor with no parameters
    }

    public Interest(int userID, String category1, String category2, String category3, String category4, String category5) {
        this.userID = userID;
        this.category1 = category1;
        this.category2 = category2;
        this.category3 = category3;
        this.category4 = category4;
        this.category5 = category5;
    }

    public Interest(int interestID, int userID, String category1, String category2, String category3, String category4, String category5) {
        this.interestID = interestID;
        this.userID = userID;
        this.category1 = category1;
        this.category2 = category2;
        this.category3 = category3;
        this.category4 = category4;
        this.category5 = category5;
    }

    public int getInterestID() {
        return interestID;
    }

    public void setInterestID(int interestID) {
        this.interestID = interestID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getCategory1() {
        return category1;
    }

    public void setCategory1(String category1) {
        this.category1 = category1;
    }

    public String getCategory2() {
        return category2;
    }

    public void setCategory2(String category2) {
        this.category2 = category2;
    }

    public String getCategory3() {
        return category3;
    }

    public void setCategory3(String category3) {
        this.category3 = category3;
    }

    public String getCategory4() {
        return category4;
    }

    public void setCategory4(String category4) {
        this.category4 = category4;
    }

    public String getCategory5() {
        return category5;
    }

    public void setCategory5(String category5) {
        this.category5 = category5;
    }

    @Override
    public String toString() {
        return "Interest{" +
                "interestID=" + interestID +
                ", userID=" + userID +
                ", category1='" + category1 + '\'' +
                ", category2='" + category2 + '\'' +
                ", category3='" + category3 + '\'' +
                ", category4='" + category4 + '\'' +
                ", category5='" + category5 + '\'' +
                '}';
    }

    public String[] toArray() {
        String[] array ={category1, category2, category3, category4, category5};
        return array;
    }


}

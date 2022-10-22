package com.example.WebShopServer.Models;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "product")
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idproduct")
    private Long Id;

    @Column(name = "name")
    private String Name;

    @Column(name = "price")
    private int Price;

    @Column(name = "description")
    private String Description;

    @Column(name = "currency")
    private String Currency;

    @Column(name = "userid")
    private int UserId;

    @Column(name = "categoryid")
    private int CategoryId;

    @Column(name = "createdtime")
    private Date dateTime;


    public Long getId() {
        return Id;
    }

    public String getName() {
        return Name;
    }

    public int getPrice() {
        return Price;
    }

    public String getDescription() {
        return Description;
    }

    public String getCurrency() {
        return Currency;
    }

    public int getUserId() {
        return UserId;
    }

    public int getCategoryId() {
        return CategoryId;
    }

    public Date getDateTime() {
        return dateTime;
    }
}

package com.example.WebShopServer.Models;

import com.fasterxml.jackson.annotation.*;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "product")
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idproduct")
    private Long id;

    @Column(name = "name")
    private String name;

    @Column(name = "price")
    private int price;

    @Column(name = "description")
    private String description;

    @Column(name = "currency")
    private String currency;

    @ManyToOne
    @JoinColumn(name = "userid")
    @JsonBackReference(value = "userproduct-movement")
    private User user;

    @ManyToOne
    @JoinColumn(name = "categoryid")
    @JsonBackReference(value = "category-movement")
    private Category category;

    @OneToMany(mappedBy = "product")
    @JsonManagedReference(value = "product-movement")
    private List<OrderProduct> orderProducts;


    @Column(name = "createdtime")
    private Date dateTime;

    public Product(){}

    public Product(String name, int price, String description, String currency, User user, Category category) {
        this.name = name;
        this.price = price;
        this.description = description;
        this.currency = currency;
        this.user = user;
        this.category = category;
        this.dateTime = new Timestamp(System.currentTimeMillis());
    }

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public int getPrice() {
        return price;
    }

    public String getDescription() {
        return description;
    }

    public String getCurrency() {
        return currency;
    }

    public User getUser() {
        return user;
    }

    public Category getCategory() {
        return category;
    }

    public Date getDateTime() {
        return dateTime;
    }



    public String toString(){
        return this.getName() + "   " + this.getCurrency();
    }
}

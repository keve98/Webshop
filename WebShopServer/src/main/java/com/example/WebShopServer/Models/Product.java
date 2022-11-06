package com.example.WebShopServer.Models;

import com.fasterxml.jackson.annotation.*;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

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
        Name = name;
        Price = price;
        Description = description;
        Currency = currency;
        this.user = user;
        this.category = category;
    }

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

    public User getUser() {
        return user;
    }

    public Category getCategory() {
        return category;
    }

    public Date getDateTime() {
        return dateTime;
    }
}

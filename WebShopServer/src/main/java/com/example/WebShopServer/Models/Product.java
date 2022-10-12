package com.example.WebShopServer.Models;

import javax.persistence.*;

@Entity
@Table(name = "product")
public class Product {

    @Id
    @SequenceGenerator(name="ProductSequence", sequenceName="seqproductid", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator ="ProductSequence")
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
}

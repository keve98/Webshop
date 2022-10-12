package com.example.WebShopServer.Models;

import javax.persistence.*;

@Entity
@Table(name = "category")
public class Category {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idcategory")
    private Long Id;

    @Column(name = "name")
    private String name;

    public Long getId() {
        return Id;
    }

    public String getName() {
        return name;
    }
}

package com.example.WebShopServer.Models;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "invoice")
@JsonIgnoreProperties({"hibernateLazyInitializer","orderProducts"})
public class Invoice {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idinvoice")
    private Long Id;

    @JsonBackReference
    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "userid")
    private User user;

    @Column(name = "amount")
    private int Amount;

    @OneToMany(mappedBy = "invoice")
    private List<OrderProduct> orderProducts;

    public Invoice(){}

    public Invoice(User user, int amount) {
        this.user = user;
        Amount = amount;
    }

    public Long getId() {
        return Id;
    }

    public User getUser() {
        return user;
    }

    public List<OrderProduct> getOrderProducts() {
        return orderProducts;
    }

    public int getAmount() {
        return Amount;
    }
}

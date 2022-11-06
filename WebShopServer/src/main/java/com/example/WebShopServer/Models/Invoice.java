package com.example.WebShopServer.Models;

import com.fasterxml.jackson.annotation.*;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "invoice")
public class Invoice {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idinvoice")
    private Long Id;


    @ManyToOne
    @JoinColumn(name = "userid")
    @JsonBackReference(value = "userinvoice-movement")
    private User user;

    @Column(name = "amount")
    private int Amount;

    @OneToMany(mappedBy = "invoice")
    @JsonManagedReference(value = "invoice-movement")
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

    public void setUser(User user) {
        this.user = user;
    }

    public void setAmount(int amount) {
        Amount = amount;
    }

    public String toString(){
        return this.user.getUsername();
    }
}

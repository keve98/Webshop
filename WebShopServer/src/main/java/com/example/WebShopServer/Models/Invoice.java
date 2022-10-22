package com.example.WebShopServer.Models;

import javax.persistence.*;

@Entity
@Table(name = "invoice")

public class Invoice {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idinvoice")
    private Long Id;

    @Column(name = "userid")
    private Long UserId;

    @Column(name = "amount")
    private int Amount;

    public Long getId() {
        return Id;
    }

    public Long getUserId() {
        return UserId;
    }

    public int getAmount() {
        return Amount;
    }
}

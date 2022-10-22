package com.example.WebShopServer.Models;

import javax.persistence.*;

@Entity
@Table(name="orderproduct")
public class OrderProduct {

    @javax.persistence.Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idorderproduct")
    private Long Id;

    @Column(name = "quantity")
    private int Quantity;

    @Column(name = "invoiceid")
    private Long InvoiceId;

    @Column(name = "productid")
    private Long ProductId;

    public Long getId() {
        return Id;
    }

    public int getQuantity() {
        return Quantity;
    }

    public Long getInvoiceId() {
        return InvoiceId;
    }

    public Long getProductId() {
        return ProductId;
    }
}

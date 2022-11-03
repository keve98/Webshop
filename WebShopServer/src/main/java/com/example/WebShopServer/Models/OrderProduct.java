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

    @ManyToOne
    @JoinColumn(name = "invoiceid")
    private Invoice invoice;

    @ManyToOne
    @JoinColumn(name = "productid")
    private Product product;

    public OrderProduct(){}

    public OrderProduct(int quantity, Invoice invoice, Product product) {
        Quantity = quantity;
        this.invoice = invoice;
        this.product = product;
    }

    public Long getId() {
        return Id;
    }

    public int getQuantity() {
        return Quantity;
    }

    public Invoice getInvoice() {
        return invoice;
    }

    public Product getProduct() {
        return product;
    }
}

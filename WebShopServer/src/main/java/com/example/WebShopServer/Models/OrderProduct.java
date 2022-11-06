package com.example.WebShopServer.Models;

import com.fasterxml.jackson.annotation.*;

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
    @JsonBackReference(value = "invoice-movement")
    private Invoice invoice;

    @ManyToOne
    @JoinColumn(name = "productid")
    @JsonBackReference(value = "product-movement")
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

    public void setQuantity(int quantity) {
        Quantity = quantity;
    }

    public void setInvoice(Invoice invoice) {
        this.invoice = invoice;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}

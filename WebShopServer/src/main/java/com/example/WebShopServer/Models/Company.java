package com.example.WebShopServer.Models;

import javax.persistence.*;

@Entity
@Table(name = "company")
public class Company {

    @Id
    @SequenceGenerator(name="CompanySequence", sequenceName="seqcompanyid", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator ="CompanySequence")
    @Column(name = "idcompany")
    private Long Id;

    @Column(name = "name")
    private String Name;

    @Column(name = "address")
    private String Address;

    public Long getId() {
        return Id;
    }

    public String getName() {
        return Name;
    }

    public String getAddress() {
        return Address;
    }
}

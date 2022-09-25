package com.example.WebShopServer.Models;


import javax.persistence.*;

@Entity
@Table(name = "user")
public class User {

    @javax.persistence.Id
    @SequenceGenerator(name="UserSequence", sequenceName="sequserid", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator ="UserSequence")
    @Column(name = "iduser")
    private Long Id;

    @Column(name = "name")
    private String Name;

    @Column(name = "username")
    private String Username;

    @Column(name = "address")
    private String Address;

    @Column(name = "password")
    private String Password;


    public Long getId() {
        return Id;
    }

    public String getName() {
        return Name;
    }

    public String getUsername() {
        return Username;
    }

    public String getAddress() {
        return Address;
    }

    public String getPassword() {
        return Password;
    }
}

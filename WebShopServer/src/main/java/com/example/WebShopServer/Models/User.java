package com.example.WebShopServer.Models;


import javax.persistence.*;

@Entity
@Table(name = "user")
public class User {

    @Id
    //@SequenceGenerator(name="UserSequence", sequenceName="sequserid", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "iduser")
    private Long Id;

    @Column(name = "name")
    private String name;

    @Column(name = "username")
    private String username;

    @Column(name = "address")
    private String address;

    @Column(name = "email")
    private String email;

    @Column(name = "password")
    private String password;

    @Column(name = "verification_code")
    private String VerificationCode;

    @Column(name = "isenabled")
    private boolean IsEnabled;

    public User(){};
    public User(String name, String username, String address, String email, String password) {
        this.name = name;
        this.username = username;
        this.address = address;
        this.email = email;
        this.password = password;
    }

    public Long getId() {
        return Id;
    }


    public String getName() {
        return name;
    }

    public String getUsername() {
        return username;
    }

    public String getAddress() {
        return address;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getVerificationCode() {
        return VerificationCode;
    }

    public boolean isEnabled() {
        return IsEnabled;
    }

    public String getEmail() {
        return email;
    }

    public String getVerificatonCode() {
        return VerificationCode;
    }

    public void setVerificatonCode(String randomCode) {
        VerificationCode = randomCode;
    }

    public void setEnabled(boolean b) {
        IsEnabled = b;
    }

    public String toString(){
        return this.getName() + "  " + this.getUsername() + "  " + this.getAddress()+ "  " + this.getEmail()
                + "  " + this.getPassword();
    }
}

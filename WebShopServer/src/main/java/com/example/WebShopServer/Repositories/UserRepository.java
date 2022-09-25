package com.example.WebShopServer.Repositories;


import com.example.WebShopServer.Models.Product;
import com.example.WebShopServer.Models.User;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserRepository extends CrudRepository<User, Long> {

    @Query(value = "select u from User u order by u.Id")
    List<User> findAll();


}

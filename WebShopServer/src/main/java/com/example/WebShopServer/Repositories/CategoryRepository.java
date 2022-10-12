package com.example.WebShopServer.Repositories;

import com.example.WebShopServer.Models.Category;
import com.example.WebShopServer.Models.Product;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CategoryRepository extends CrudRepository<Category, Long> {
    @Query(value = "select c from Category c order by c.Id")
    List<Category> findAll();

}

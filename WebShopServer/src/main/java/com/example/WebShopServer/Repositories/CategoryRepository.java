package com.example.WebShopServer.Repositories;

import com.example.WebShopServer.Models.Category;
import com.example.WebShopServer.Models.Product;
import com.example.WebShopServer.Models.User;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CategoryRepository extends CrudRepository<Category, Long> {
    @Query(value = "select c from Category c order by c.Id")
    List<Category> findAll();

    @Query(value = "select m from Category m where m.Id = :categoryid")
    Category findCategoryById(@Param("categoryid") Long id);
}

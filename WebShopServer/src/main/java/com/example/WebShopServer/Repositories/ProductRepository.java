package com.example.WebShopServer.Repositories;


import com.example.WebShopServer.Models.Product;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;


@Repository
public interface ProductRepository extends CrudRepository<Product, Long> {

    @Query(value = "select p from Product p order by p.Id")
    List<Product> findAll();

    @Query(value = "select p from Product p where p.user.Id = :userid")
    List<Product> findProductByUserId(@Param("userid") int userid);


    @Query(value = "select p from Product p where p.category.Id = :categoryid")
    List<Product> findProductsForCategory(@Param("categoryid") Long categoryid);

    @Query(value = "select p from Product p where p.dateTime >= :createdDateTime")
    List<Product> findNewProductsForDateTime(@Param("createdDateTime") Date createdDateTime);

    @Query(value = "select p from Product p where p.Name like %:str%")
    List<Product> findProductsBySearchText(@Param("str") String str);

    @Query(value = "select p from Product p where p.Name like %:str% and p.category.Id = :categoryid")
    List<Product> findProductsBySearchTextAndCategory(@Param("str") String str, @Param("categoryid") int categoryid);
}

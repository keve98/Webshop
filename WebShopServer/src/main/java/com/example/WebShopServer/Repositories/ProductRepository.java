package com.example.WebShopServer.Repositories;


import com.example.WebShopServer.Models.Product;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface ProductRepository extends CrudRepository<Product, Long> {

    @Query(value = "select p from Product p order by p.Id")
    List<Product> findAll();

    @Query(value = "select p from Product p where p.CompanyId like :#{#companyid}")
    List<Product> findProductByCompanyId(@Param("companyid") String companyid);
}

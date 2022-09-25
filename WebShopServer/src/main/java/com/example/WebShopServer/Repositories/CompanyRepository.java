package com.example.WebShopServer.Repositories;

import com.example.WebShopServer.Models.Company;
import com.example.WebShopServer.Models.Product;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CompanyRepository extends CrudRepository<Company, Long> {

    @Query(value = "select c from Company c order by c.Id")
    List<Company> findAll();

}

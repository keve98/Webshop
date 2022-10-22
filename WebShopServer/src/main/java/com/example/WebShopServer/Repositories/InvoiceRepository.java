package com.example.WebShopServer.Repositories;

import com.example.WebShopServer.Models.Invoice;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface InvoiceRepository extends CrudRepository<Invoice, Long> {

    @Query(value = "select i from Invoice i order by i.Id")
    List<Invoice> findAll();
}

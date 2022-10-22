package com.example.WebShopServer.Repositories;

import com.example.WebShopServer.Models.OrderProduct;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderProductRepository extends CrudRepository<OrderProduct, Long> {

    @Query(value = "select o from OrderProduct o order by o.Id")
    List<OrderProduct> findAll();
}

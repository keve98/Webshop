package com.example.WebShopServer.Repositories;


import com.example.WebShopServer.Models.*;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;


@Repository
public interface ProductRepository extends CrudRepository<Product, Long> {

    @Query(value = "select p from Product p order by p.id")
    List<Product> findAll();

    @Query(value = "select p from Product p where p.user.Id = :userid")
    List<Product> findProductByUserId(@Param("userid") int userid);


    @Query(value = "select p from Product p where p.category.Id = :categoryid")
    List<Product> findProductsForCategory(@Param("categoryid") Long categoryid);

    @Query(value = "select p from Product p where p.dateTime >= :createdDateTime")
    List<Product> findNewProductsForDateTime(@Param("createdDateTime") Date createdDateTime);

    @Query(value = "select p from Product p where p.name like %:str%")
    List<Product> findProductsBySearchText(@Param("str") String str);

    @Query(value = "select p from Product p where p.name like %:str% and p.category.Id = :categoryid")
    List<Product> findProductsBySearchTextAndCategory(@Param("str") String str, @Param("categoryid") Long categoryid);

    @Query(value = "select p from Product p where p.id = :id")
    Product getProductById(@Param("id") Long id);

    @Query(value = "select product.idproduct,\n" +
            "\t\tproduct.name,\n" +
            "        product.price,\n" +
            "        product.description,\n" +
            "        product.currency,\n" +
            "        product.userid,\n" +
            "        product.categoryid," +
            "       product.createdTime\n" +
            " FROM product, orderproduct, invoice where product.idproduct = orderproduct.productid and\n" +
            "orderproduct.invoiceid = invoice.idinvoice and \n" +
            "invoice.userid = :userid\n" +
            "group by product.idproduct\n" +
            "order by count(*) desc\n" +
            "limit 10\n", nativeQuery = true)
    List<Product> getTheMostRecentOrderedProductsForUser(@Param("userid") Long userid);

    @Query(value = "select product.idproduct,\n" +
            "\t\tproduct.name,\n" +
            "        product.price,\n" +
            "        product.description,\n" +
            "        product.currency,\n" +
            "        product.userid,\n" +
            "        product.categoryid,\n" +
            "        product.createdTime from orderproduct, product \n" +
            "        where product.idproduct = orderproduct.productid \n" +
            "        and orderproduct.invoiceid = :invoiceid", nativeQuery = true)
    List<Product> getProductsForInvoice(@Param("invoiceid") Long invoiceid);
}

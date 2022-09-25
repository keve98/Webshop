package com.example.WebShopServer.Controllers;

import com.example.WebShopServer.Models.Product;
import com.example.WebShopServer.Services.ProductService;
import org.springframework.data.repository.query.Param;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.ws.rs.QueryParam;
import javax.ws.rs.core.*;

import java.util.List;

@RestController
public class ProductController {

    ProductService productService;

    public ProductController(ProductService p){
        this.productService = p;
    }

    @GetMapping("/products")
    public ResponseEntity<List<Product>> getProducts(){
        List<Product> products = productService.getAllProducts();
        return new ResponseEntity<>(products, HttpStatus.OK);
    }

    @GetMapping("/products/search")
    public ResponseEntity<List<Product>> getProductsByCompanyId(@QueryParam("companyid") String companyid){
        List<Product> products = productService.getProductsByCompanyId(companyid);
        return new ResponseEntity<>(products, HttpStatus.OK);
    }

}

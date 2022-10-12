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
        System.out.println("Get all products");
        return new ResponseEntity<>(products, HttpStatus.OK);
    }

    @GetMapping("/products/search")
    public ResponseEntity<List<Product>> getProductsByUserId(@QueryParam("userid") int userid){
        List<Product> products = productService.getProductsByUserId(userid);
        return new ResponseEntity<>(products, HttpStatus.OK);
    }

    @GetMapping("/products/findCategory")
    public ResponseEntity<List<Product>> getProductsForCategory(@QueryParam("categoryid") int categoryid){
        List<Product> products = productService.getProductsForCategory(categoryid);
        return new ResponseEntity<>(products, HttpStatus.OK);
    }

}

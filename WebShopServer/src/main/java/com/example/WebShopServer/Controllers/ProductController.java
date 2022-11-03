package com.example.WebShopServer.Controllers;

import com.example.WebShopServer.Models.Product;
import com.example.WebShopServer.Services.ProductService;
import org.springframework.data.repository.query.Param;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.ws.rs.QueryParam;
import javax.ws.rs.core.*;

import java.util.Date;
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
    public ResponseEntity<List<Product>> getProductsForCategory(@QueryParam("categoryid") Long categoryid){
        List<Product> products = productService.getProductsForCategory(categoryid);
        return new ResponseEntity<>(products, HttpStatus.OK);
    }

    @GetMapping("/products/news")
    public ResponseEntity<List<Product>> getNewProductsByDateTime(@QueryParam("date") @DateTimeFormat(pattern = "yyyy-MM-dd") Date date) {
        List<Product> products = productService.getNewProductsForDateTime(date);
        return new ResponseEntity<>(products, HttpStatus.OK);
    }

    @GetMapping("/products/findName")
    public ResponseEntity<List<Product>> getProductsBySearchText(@QueryParam("str") String str){
        List<Product> products = productService.getProductsBySearchText(str);
        return new ResponseEntity<>(products, HttpStatus.OK);
    }

    @GetMapping("/products/findNameAndCat")
    public ResponseEntity<List<Product>> getProductsBySearchTextAndCategoryId(@QueryParam("str") String str, @QueryParam("categoreyid") int categoryid){
        List<Product> products = productService.getProductsBySearchTextAndCategoryId(str, categoryid);
        return new ResponseEntity<>(products, HttpStatus.OK);
    }

    @PostMapping(value = "/product/save")
    public ResponseEntity<Product> saveProduct(@RequestBody Product newProduct){
        Product newProductEntity = new Product(newProduct.getName(), newProduct.getPrice(), newProduct.getDescription(), newProduct.getCurrency(), newProduct.getUser(), newProduct.getCategory());
        productService.saveProduct(newProductEntity);

        return new ResponseEntity<>(newProductEntity, HttpStatus.OK);
    }

}

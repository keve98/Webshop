package com.example.WebShopServer.Controllers;

import com.example.WebShopServer.Models.*;
import com.example.WebShopServer.Services.CategoryService;
import com.example.WebShopServer.Services.ProductService;
import com.example.WebShopServer.Services.UserService;
import org.springframework.data.repository.query.Param;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.ws.rs.PathParam;
import javax.ws.rs.QueryParam;

import java.util.Date;
import java.util.List;

@RestController
public class ProductController {

    ProductService productService;
    CategoryService categoryService;
    UserService userService;

    public ProductController(ProductService p, UserService u, CategoryService c){
        this.userService = u;
        this.productService = p;
        this.categoryService = c;
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
    public ResponseEntity<List<Product>> getProductsBySearchText(@PathParam("str") String str){
        List<Product> products = productService.getProductsBySearchText(str);
        return new ResponseEntity<>(products, HttpStatus.OK);
    }

    @GetMapping("/products/findNameAndCat")
    public ResponseEntity<List<Product>> getProductsBySearchTextAndCategoryId(@PathParam("str") String str, @PathParam("categoreyid") Long categoryid){
        List<Product> products = productService.getProductsBySearchTextAndCategoryId(str, categoryid);
        return new ResponseEntity<>(products, HttpStatus.OK);
    }

    @PostMapping(value = "/product/save")
    public ResponseEntity<Product> saveProduct(@RequestParam("userid") Long userid, @RequestParam("categoryid") Long categoryid,  @RequestBody Product newProduct){
        User user = userService.getUserById(userid);
        Category category = categoryService.getCategoryById(categoryid);
        Product newProductEntity = new Product(newProduct.getName(), newProduct.getPrice(), newProduct.getDescription(), newProduct.getCurrency(), user, category);
        productService.saveProduct(newProductEntity);

        return new ResponseEntity<>(newProductEntity, HttpStatus.OK);
    }

    @GetMapping("/products/findMostRecent")
    public ResponseEntity<List<Product>> getTheMostRecentProductsForUser(@PathParam("userid") Long userid){
        List<Product> products = productService.getTheMostRecentProductsForUser(userid);
        return new ResponseEntity<>(products, HttpStatus.OK);
    }

    @GetMapping("/products/findForInvoice")
    public ResponseEntity<List<Product>> getProductsForInvoice(@PathParam("invoiceid") Long invoiceid){
        List<Product> products = productService.getProductsForInvoice(invoiceid);
        return new ResponseEntity<>(products, HttpStatus.OK);
    }
}

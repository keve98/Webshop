package com.example.WebShopServer.Controllers;

import com.example.WebShopServer.Models.Category;
import com.example.WebShopServer.Services.CategoryService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class CategoryController {

    CategoryService categoryService;

    public CategoryController(CategoryService c){categoryService = c;}

    @GetMapping("/categories")
    public ResponseEntity<List<Category>> getCategories(){
        List<Category> categories = categoryService.getAllCategories();
        System.out.println("Get all categories");
        return new ResponseEntity<>(categories, HttpStatus.OK);
    }


}

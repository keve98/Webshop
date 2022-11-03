package com.example.WebShopServer.Services;

import com.example.WebShopServer.Models.Category;
import com.example.WebShopServer.Repositories.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryService {

    private final CategoryRepository categoryRepository;

    @Autowired
    public CategoryService(CategoryRepository c){categoryRepository = c;}

    public List<Category> getAllCategories(){return categoryRepository.findAll();}

}

package com.example.WebShopServer.Services;

import com.example.WebShopServer.Models.Product;
import com.example.WebShopServer.Repositories.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductService {

    private final ProductRepository productRepository;

    @Autowired
    public ProductService(ProductRepository p){
        productRepository = p;
    }

    public List<Product> getAllProducts(){
        return productRepository.findAll();
    }

    public List<Product> getProductsByUserId(int userid){
        return productRepository.findProductByUserId(userid);
    }

    public List<Product> getProductsForCategory(int categoryid) {
        return productRepository.findProductsForCategory(categoryid);
    }
}

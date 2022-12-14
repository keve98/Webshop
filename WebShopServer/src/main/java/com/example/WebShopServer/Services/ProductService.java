package com.example.WebShopServer.Services;

import com.example.WebShopServer.Models.Product;
import com.example.WebShopServer.Repositories.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
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

    public List<Product> getProductsForCategory(Long categoryid) {
        return productRepository.findProductsForCategory(categoryid);
    }

    public List<Product> getNewProductsForDateTime(Date date){
        return productRepository.findNewProductsForDateTime(date);
    }

    public List<Product> getProductsBySearchText(String str) {
        return productRepository.findProductsBySearchText(str);
    }

    public List<Product> getProductsBySearchTextAndCategoryId(String str, Long categoryid) {
        return productRepository.findProductsBySearchTextAndCategory(str, categoryid);
    }

    public void saveProduct(Product newProduct) {
        productRepository.save(newProduct);
    }

    public Product getProductById(Long productid) {
        return productRepository.getProductById(productid);
    }

    public List<Product> getTheMostRecentProductsForUser(Long userid){return productRepository.getTheMostRecentOrderedProductsForUser(userid);}

    public List<Product> getProductsForInvoice(Long invoiceid){return productRepository.getProductsForInvoice(invoiceid);}
}

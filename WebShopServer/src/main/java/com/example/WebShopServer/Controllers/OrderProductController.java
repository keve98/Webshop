package com.example.WebShopServer.Controllers;


import com.example.WebShopServer.Models.OrderProduct;
import com.example.WebShopServer.Services.OrderProductService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class OrderProductController {

    OrderProductService orderProductService;

    public OrderProductController(OrderProductService orderProductService) {
        this.orderProductService = orderProductService;
    }

    @GetMapping("/orderproducts")
    public ResponseEntity<List<OrderProduct>> getOrderProducts(){
        List<OrderProduct> orderproducts = orderProductService.getAllOrderProducts();
        return new ResponseEntity<>(orderproducts, HttpStatus.OK);
    }
}

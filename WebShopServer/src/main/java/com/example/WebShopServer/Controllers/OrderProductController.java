package com.example.WebShopServer.Controllers;


import com.example.WebShopServer.Models.OrderProduct;
import com.example.WebShopServer.Models.Product;
import com.example.WebShopServer.Services.OrderProductService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.ws.rs.QueryParam;
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

    @GetMapping("/orderproductsforinvoice")
    public ResponseEntity<List<OrderProduct>> getOrderProductsByInvoiceId(@QueryParam("invoiceid") int invoiceid){
        List<OrderProduct> orderproducts = orderProductService.getOrderProductsByInvoiceId(invoiceid);
        return new ResponseEntity<>(orderproducts, HttpStatus.OK);
    }

    @PostMapping(value = "/orderproduct/save")
    public ResponseEntity<OrderProduct> saveOrderProduct(@RequestBody OrderProduct newOrderProduct){
        OrderProduct newOrderProductEntity = new OrderProduct(newOrderProduct.getQuantity(), newOrderProduct.getInvoice(), newOrderProduct.getProduct());
        orderProductService.saveOrderProduct(newOrderProductEntity);

        return new ResponseEntity<>(newOrderProductEntity, HttpStatus.OK);
    }
}

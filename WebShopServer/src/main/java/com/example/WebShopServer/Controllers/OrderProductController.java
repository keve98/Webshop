package com.example.WebShopServer.Controllers;


import com.example.WebShopServer.Models.Invoice;
import com.example.WebShopServer.Models.OrderProduct;
import com.example.WebShopServer.Models.Product;
import com.example.WebShopServer.Services.InvoiceService;
import com.example.WebShopServer.Services.OrderProductService;
import com.example.WebShopServer.Services.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.ws.rs.PathParam;
import javax.ws.rs.QueryParam;
import java.util.List;

@RestController
public class OrderProductController {

    OrderProductService orderProductService;
    InvoiceService invoiceService;
    ProductService productService;

    @Autowired
    public OrderProductController(OrderProductService orderProductService,
                                  InvoiceService invoiceService,
                                  ProductService productService) {
        this.orderProductService = orderProductService;
        this.invoiceService = invoiceService;
        this.productService = productService;
    }

    @GetMapping("/orderproducts")
    public ResponseEntity<List<OrderProduct>> getOrderProducts(){
        List<OrderProduct> orderproducts = orderProductService.getAllOrderProducts();
        return new ResponseEntity<>(orderproducts, HttpStatus.OK);
    }

    @GetMapping("/orderproducts/findForInvoice")
    public ResponseEntity<List<OrderProduct>> getOrderProductsByInvoiceId(@PathParam("invoiceid") Long invoiceid){
        List<OrderProduct> orderproducts = orderProductService.getOrderProductsByInvoiceId(invoiceid);
        return new ResponseEntity<>(orderproducts, HttpStatus.OK);
    }

    @PostMapping(value = "/orderproduct/save")
    public ResponseEntity<OrderProduct> saveOrderProduct(@RequestParam("invoiceid") Long invoiceid, @RequestParam("productid") Long productid, @RequestBody OrderProduct newOrderProduct){

        Invoice invoice = invoiceService.getInvoiceByID(invoiceid);

        Product product = productService.getProductById(productid);

        OrderProduct newOrderProductEntity = new OrderProduct(newOrderProduct.getQuantity(), invoice, product);


        orderProductService.saveOrderProduct(newOrderProductEntity);

        return new ResponseEntity<>(newOrderProductEntity, HttpStatus.OK);
    }
}

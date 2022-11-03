package com.example.WebShopServer.Controllers;

import com.example.WebShopServer.Models.Invoice;
import com.example.WebShopServer.Models.OrderProduct;
import com.example.WebShopServer.Models.Product;
import com.example.WebShopServer.Models.User;
import com.example.WebShopServer.Services.InvoiceService;
import com.example.WebShopServer.Services.OrderProductService;
import com.example.WebShopServer.Services.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Optional;

@RestController
public class InvoiceController {

    InvoiceService invoiceService;

    OrderProductService orderProductService;

    UserService userService;

    public InvoiceController(InvoiceService invoiceService) {
        this.invoiceService = invoiceService;
    }

    @GetMapping("/invoices")
    public ResponseEntity<List<Invoice>> getInvoices(){
        List<Invoice> invoices = invoiceService.getAllInvoices();
        return new ResponseEntity<>(invoices, HttpStatus.OK);
    }

    @PostMapping(value = "/invoice/save")
    public ResponseEntity<Invoice> saveInvoice(@RequestBody Invoice newInvoice){
        Optional<User> user = userService.getUserById(newInvoice.getUser().getId());
        User userentity = new User(user.)
        Invoice newInvoiceEntity = new Invoice(newInvoice.getUser(), newInvoice.getAmount());
        System.out.println(newInvoiceEntity.getId() + "\t" + newInvoiceEntity.getId());
        invoiceService.saveInvoice(newInvoiceEntity);

        return new ResponseEntity<>(newInvoiceEntity, HttpStatus.OK);
    }
}

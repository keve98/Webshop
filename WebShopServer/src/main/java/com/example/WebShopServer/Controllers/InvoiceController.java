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
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
public class InvoiceController {
    InvoiceService invoiceService;
    UserService userService;

    public InvoiceController(InvoiceService invoiceService, UserService userService) {
        this.invoiceService = invoiceService;
        this.userService = userService;
    }

    @GetMapping("/invoices")
    public ResponseEntity<List<Invoice>> getInvoices(){
        List<Invoice> invoices = invoiceService.getAllInvoices();
        return new ResponseEntity<>(invoices, HttpStatus.OK);
    }

    @GetMapping("/invoiceforuser")
    public ResponseEntity<List<Invoice>> getInvoicesForUser(@RequestParam("userid") Long userid){
        List<Invoice> invoices = invoiceService.getInvoicesForUser(userid);
        return new ResponseEntity<>(invoices, HttpStatus.OK);
    }

    @PostMapping(value = "/invoice/save")
    public ResponseEntity<Invoice> saveInvoice(@RequestParam("userid") Long userid, @RequestBody Invoice newInvoice){
        User user = userService.getUserById(userid);
        Invoice newInvoiceEntity = new Invoice(user, newInvoice.getAmount());
        invoiceService.saveInvoice(newInvoiceEntity);
        return new ResponseEntity<>(newInvoiceEntity, HttpStatus.OK);
    }
}

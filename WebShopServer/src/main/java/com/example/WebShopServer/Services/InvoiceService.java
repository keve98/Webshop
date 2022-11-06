package com.example.WebShopServer.Services;

import com.example.WebShopServer.Models.Invoice;
import com.example.WebShopServer.Repositories.InvoiceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class InvoiceService {

    private final InvoiceRepository invoiceRepository;



    @Autowired
    public InvoiceService(InvoiceRepository invoiceRepository) {
        this.invoiceRepository = invoiceRepository;
    }

    public List<Invoice> getAllInvoices(){return invoiceRepository.findAll();}
    public List<Invoice> getInvoicesForUser(Long userid){return invoiceRepository.getInvoiceForUserById(userid);}

    public Invoice getInvoiceByID(Long id){
        return invoiceRepository.getInvoiceById(id);
    }

    public void saveInvoice(Invoice newInvoiceEntity) {
        invoiceRepository.save(newInvoiceEntity);
    }
}

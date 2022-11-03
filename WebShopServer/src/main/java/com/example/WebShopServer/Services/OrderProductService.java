package com.example.WebShopServer.Services;

import com.example.WebShopServer.Models.OrderProduct;
import com.example.WebShopServer.Repositories.OrderProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderProductService {

    private final OrderProductRepository orderProductRepository;

    @Autowired
    public OrderProductService(OrderProductRepository orderProductRepository) {
        this.orderProductRepository = orderProductRepository;
    }

    public List<OrderProduct> getAllOrderProducts(){return orderProductRepository.findAll();}

    public List<OrderProduct> getOrderProductsByInvoiceId(int invoiceid) {
        return orderProductRepository.findOrderProductsByInvoiceId(invoiceid);
    }

    public void saveOrderProduct(OrderProduct newOrderProductEntity) {
        orderProductRepository.save(newOrderProductEntity);
    }
}

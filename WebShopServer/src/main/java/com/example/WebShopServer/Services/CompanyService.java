package com.example.WebShopServer.Services;

import com.example.WebShopServer.Models.Company;
import com.example.WebShopServer.Repositories.CompanyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CompanyService {

    private final CompanyRepository companyRepository;

    @Autowired
    public CompanyService(CompanyRepository c){
        companyRepository = c;
    }

    public List<Company> getAllCompanies(){
        return companyRepository.findAll();
    }

}
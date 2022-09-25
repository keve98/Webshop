package com.example.WebShopServer.Controllers;

import com.example.WebShopServer.Models.Company;
import com.example.WebShopServer.Services.CompanyService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class CompanyController {

    CompanyService companyService;

    public CompanyController(CompanyService c){companyService = c;}

    @GetMapping("/companies")
    public ResponseEntity<List<Company>> getCompanies(){
        List<Company> companies = companyService.getAllCompanies();
        return new ResponseEntity<>(companies, HttpStatus.OK);
    }


}

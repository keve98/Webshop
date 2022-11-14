//
//  ServerCommunication.swift
//  WebShop
//
//  Created by Tóth Keve András on 2022. 10. 06..
//

import Foundation
import SwiftUI

class ServerCommunication : ObservableObject{    
    @Published var baseUrl: String = "http://localhost:8080/"
    
    static var loggedInUser : User = User(id:0, name: "", username: "", password: "", address: "", email: "")
    static var loginSuccess = false
    
    
    func getAllProducts(completion:@escaping([Product]) ->()){
        guard let url = URL(string:baseUrl+"products")else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){
             data, response, error in
            
            
            //convert to JSON
            if let data = data{
                do{
                    let products = try JSONDecoder().decode([Product].self, from: data)
                    DispatchQueue.main.async {
                        completion(products)
                    }
                    
                }
                catch{
                    print(error)
                }
            }
        }
        
        task.resume()
    }
    
    func getAllProductsBySearchString(str: String, completion:@escaping([Product]) ->()){
        guard let url = URL(string:baseUrl+"products/findName?str=" + str)else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){
             data, response, error in
            
            
            //convert to JSON
            if let data = data{
                do{
                    let products = try JSONDecoder().decode([Product].self, from: data)
                    DispatchQueue.main.async {
                        completion(products)
                    }
                    
                }
                catch{
                    print(error)
                }
            }
        }
        
        task.resume()
    }
    
    func getAllProductsBySearchStringAndCategory(str: String, categoryid: Int, completion:@escaping([Product]) ->()){
        guard let url = URL(string:baseUrl+"products/findName?str=" + str + "&categoryid=" + String(categoryid))else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){
             data, response, error in
            
            
            //convert to JSON
            if let data = data{
                do{
                    let products = try JSONDecoder().decode([Product].self, from: data)
                    DispatchQueue.main.async {
                        completion(products)
                    }
                    
                }
                catch{
                    print(error)
                }
            }
        }
        
        task.resume()
        
        
    }
    
    func login(userName: String, pw: String, completion:@escaping(Bool) ->()){
        
        
        guard let url = URL(string: baseUrl + "login")else{
            print("Not found url")
            return
        }
        
        let newUser = User(id: 0, name: "", username: userName, password: pw, address: "", email: "")
        let json = try! JSONEncoder().encode(newUser)
        print(json)
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.httpBody = json
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request){
            data, response, error in
            
            if let data = data{
                do{
                    let result = try JSONDecoder().decode(User.self, from: data)
                    DispatchQueue.main.async {
                        ServerCommunication.loggedInUser = result
                        completion(true)
                    }
                    ServerCommunication.loginSuccess = true
                }
                catch{
                    print(error)
                }
            }
        }.resume()
    }
    
    func saveInvoice(user: User, amount: Int, completion:@escaping(Invoice) ->()) {
        guard let url = URL(string:baseUrl + "invoice/save?userid=" + String(user.id))else{
            print("Not found url")
            return
        }
        
        let newInvoice = Invoice(id: 0, amount: amount, orderProducts: nil, user: user)
        let json = try! JSONEncoder().encode(newInvoice)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = json
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request){
            data, response, error in
            if let data = data {
                do{
                    let result = try JSONDecoder().decode(Invoice.self, from: data)
                    DispatchQueue.main.async {
                        print(result)
                        completion(result)
                    }
                }
                catch{
                    print(error)
                }
            }
        }.resume()
    }
    
    func saveOrderProduct(quantity: Int, invoice: Invoice, product: Product){
        
        guard let url = URL(string:baseUrl + "orderproduct/save?invoiceid=" + String(invoice.id) + "&productid=" + String(product.id))else{
            print("Not found url")
            return
        }
        
        let neworderProduct = OrderProduct(id: 0, quantity: quantity, invoice: invoice, product: product)
        let json = try! JSONEncoder().encode(neworderProduct)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = json
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request){
            data, response, error in
            if let data = data {
                do{
                    let result = try JSONDecoder().decode(OrderProduct.self, from: data)
                    DispatchQueue.main.async {
                        print(result)
                    }
                }
                catch{
                    print(error)
                }
            }
        }.resume()
    }
    
    func registerUser(Name: String, Username: String, Password: String, Address: String, Email: String) -> Bool{
        
        var registerSucessful = false
        
        guard let url = URL(string:baseUrl + "user/save")else{
            print("Not found url")
            return false
        }
        
        let newUser = User(id: 0, name: Name, username: Username, password: Password, address: Address, email: Email)
        let json = try! JSONEncoder().encode(newUser)
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.httpBody = json
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
       URLSession.shared.dataTask(with: request){
           data, response, error in
            if let data = data{
            do{
                let result = try JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async {
                    print(result)
                }
                
                registerSucessful = true
                
            }
            catch{
                print(error)
            }
                
            }
        }.resume()
        return registerSucessful
    }
    
    func getAllCategories(completion:@escaping([Category]) ->()){
        guard let url = URL(string:baseUrl + "categories")else{
            print("Not found url")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){
             data, response, error in
            
            
            //convert to JSON
            if let data = data{
                do{
                    let categories = try JSONDecoder().decode([Category].self, from: data)
                    DispatchQueue.main.async {
                        completion(categories)
                    }
                    
                }
                catch{
                    print(error)
                }
            }
        }
        
        task.resume()
    }
    
    func getInvoicesForUser(user: User, completion:@escaping([Invoice]) -> ()){
        guard let url = URL(string:baseUrl + "invoiceforuser?userid=" + String(user.id))else{
            print("Not found url")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){
             data, response, error in
            
            //convert to JSON
            if let data = data{
                do{
                    let invoices = try JSONDecoder().decode([Invoice].self, from: data)
                    DispatchQueue.main.async {
                        completion(invoices)
                    }
                    
                }
                catch{
                    print(error)
                }
            }
        }
        
        task.resume()
        
    }
    
    func getProductsForCategory(categoryid: Int, completion:@escaping([Product]) ->()){
        guard let url = URL(string:baseUrl+"products/findCategory?categoryid="+String(categoryid))else{
            print("Not found url")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            
            //convert to JSON
            if let data = data{
                do{
                    let products = try JSONDecoder().decode([Product].self, from: data)
                    DispatchQueue.main.async {
                        completion(products)
                    }
                    
                }
                catch{
                    print(error)
                }
            }
        }
        
        task.resume()
    }
    
    func getNewProducts(completion:@escaping([Product]) ->()){
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let yearString = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "MM"
        let monthString = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "dd"
        let dayString = dateFormatter.string(from: date)
        guard let url = URL(string:baseUrl+"products/news?date="+yearString+"-"+monthString+"-"+dayString)else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            
            //convert to JSON
            if let data = data{
                do{
                    let products = try JSONDecoder().decode([Product].self, from: data)
                    DispatchQueue.main.async {
                        completion(products)
                    }
                    
                }
                catch{
                    print(error)
                }
            }
        }
        
        task.resume()
    }
    
    func getMostRecentProductsForUser(user: User, completion:@escaping([Product]) -> ()){
        guard let url = URL(string:baseUrl+"products/findMostRecent?userid=" + String(user.id))else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            
            //convert to JSON
            if let data = data{
                do{
                    let products = try JSONDecoder().decode([Product].self, from: data)
                    DispatchQueue.main.async {
                        completion(products)
                    }
                    
                }
                catch{
                    print(error)
                }
            }
        }
        
        task.resume()
    }
    
    func logout(){
        ServerCommunication.loggedInUser = User(id: 0, name: "", username: "", password: "", address: "", email: "")
        ServerCommunication.loginSuccess = false
        
    }
    
}



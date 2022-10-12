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
    
    static var loggedInUser : User = User(name: "", username: "", password: "", address: "", email: "")
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
    
    func login(userName: String, pw: String, completion:@escaping(Bool) ->()){
        
        
        guard let url = URL(string: baseUrl + "login")else{
            print("Not found url")
            return
        }
        
        let newUser = User(name: "", username: userName, password: pw, address: "", email: "")
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
    
    func registerUser(Name: String, Username: String, Password: String, Address: String, Email: String) -> Bool{
        
        var registerSucessful = false
        
        guard let url = URL(string:baseUrl + "save")else{
            print("Not found url")
            return false
        }
        
        let newUser = User(name: Name, username: Username, password: Password, address: Address, email: Email)
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
                let result = try JSONDecoder().decode([User].self, from: data)
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
    
    func getProductsForCategory(categoryid: Int, completion:@escaping([Product]) ->()){
        guard let url = URL(string:baseUrl+"products/findCategory?categoryid="+String(categoryid))else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            
            //convert to JSON
            if let data = data{
                do{
                    let products = try JSONDecoder().decode([Product].self, from: data)
                    DispatchQueue.main.async {
                        //ServerCommunication.products = products
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
    
    func logout(){
        ServerCommunication.loggedInUser = User(name: "", username: "", password: "", address: "", email: "")
        ServerCommunication.loginSuccess = false
        
    }
    
}



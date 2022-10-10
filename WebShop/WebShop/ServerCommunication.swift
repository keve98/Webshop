//
//  ServerCommunication.swift
//  WebShop
//
//  Created by Tóth Keve András on 2022. 10. 06..
//

import Foundation
import SwiftUI

class ServerCommunication : ObservableObject{
    
    @Published var products=[Product]()
    
    @Published var baseUrl: String = "http://localhost:8080/"
    
    static var loggedInUser : User = User(name: "", username: "", password: "", address: "", email: "")
    
    func getAllProducts(){
        guard let url = URL(string:baseUrl+"products")else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){
            [weak self] data, response, error in
            
            
            //convert to JSON
            if let data = data{
                do{
                    let products = try JSONDecoder().decode([Product].self, from: data)
                    DispatchQueue.main.async {
                        self?.products = products
                    }
                    
                }
                catch{
                    print(error)
                }
            }
        }
        
        task.resume()
    }
    
    func login(userName: String, pw: String){
        
        
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
    
}



//
//  LoginValidator.swift
//  WebShop
//
//  Created by Tóth Keve András on 2022. 10. 06..
//

import Foundation

class LoginValidator: ObservableObject{
    
    @Published var username = ""
    @Published var password = ""
    

    
    func isUsernameValid() -> Bool{
        return username.isEmpty ? false : true
    }
    
    func isPasswordValid() -> Bool{
        return password.isEmpty ? false : true
    }
    
    var usernamePrompt: String{
        if isUsernameValid(){
            return ""
        }else{
            return "Enter your username."
        }
    }
    
    var passwordPrompt: String{
        if isPasswordValid(){
            return ""
        }else{
            return "Enter your password."
        }
    }
    
    var isLoginComplete:Bool{
        if !isUsernameValid() ||
            !isPasswordValid(){
            return false
        }else{
            return true
        }
    }
    
}

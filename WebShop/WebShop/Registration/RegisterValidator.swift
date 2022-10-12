//
//  RegisterValidator.swift
//  WebShop
//
//  Created by Tóth Keve András on 2022. 10. 06..
//

import Foundation

class RegisterValidator:ObservableObject{
    @Published var name = ""
    @Published var username = ""
    @Published var address = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    func isPasswordsMatch() -> Bool {
        password == confirmPassword
    }
    
    func isPasswordValid() -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@","^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,15}$")
        return passwordTest.evaluate(with: password)
    }
    
    func isEmailValid() -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@",
                                    "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$")
        return emailTest.evaluate(with: email)
    }
    
    func isNameValid() -> Bool{
        return name.isEmpty ? false : true
    }
    
    func isUsernameValid() -> Bool{
        return username.isEmpty ? false : true
    }
    
    func isAddressValid() -> Bool{
        return address.isEmpty ? false : true
    }

    
    var isSignUpComplete: Bool {
        if !isPasswordsMatch() ||
        !isPasswordValid() ||
        !isEmailValid() ||
        !isNameValid() ||
        !isUsernameValid() ||
        !isAddressValid() {
            return false
        }
        return true
    }
    
    var confirmPwPrompt: String {
        if isPasswordsMatch() {
            return ""
        } else {
            return "Password fields do not match."
        }
    }
    
    var emailPrompt: String {
        if isEmailValid() {
            return ""
        } else {
            return "Enter a valid email address."
        }
    }
    
    var passwordPrompt: String {
        if isPasswordValid() {
            return ""
        } else {
            return "Must be between 8 and 15 characters containing at least one number and one capital letter"
        }
    }
    
    var confirmNamePrompt: String{
        if isNameValid(){
            return ""
        }else{
            return "Enter your name."
        }
    }
    
    var confirmUsernamePrompt:String{
        if isUsernameValid(){
            return ""
        }else{
            return "Enter your username."
        }
    }
    
    var confirmAddressPrompt:String{
        if isAddressValid(){
            return ""
        }else{
            return "Enter your address."
        }
    }
}

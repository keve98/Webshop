//
//  SellProductValidator.swift
//  WebShop
//
//  Created by Tóth Keve András on 2022. 11. 20..
//

import Foundation

class SellProductValidator : ObservableObject{
    @Published var name = ""
    @Published var price = ""
    @Published var description = ""
    
    
    func isNameValid() -> Bool{
        return name.isEmpty ? false : true
    }
    
    func isPriceValid() -> Bool{
        let priceTest = NSPredicate(format: "SELF MATCHES %@","/^([1-9][0-9]*)$/")
        return priceTest.evaluate(with: price) && Int(price)! > 0 ? false : true
    }
    
    
    var isNewProductComplete: Bool {
        if  !isNameValid() ||
            !isPriceValid() {
            return false
        }
        return true
    }
    
    
    var confirmNamePrompt: String{
        if isNameValid(){
            return ""
        }else{
            return "Enter the product name."
        }
    }
    
    
    var confirmPricePrompt:String{
        if isPriceValid(){
            return ""
        }else{
            return "Enter the product price in HUF."
        }
    }
}

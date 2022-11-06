//
//  Models.swift
//  WebShop
//
//  Created by Tóth Keve András on 2022. 10. 03..
//

import Foundation
import SwiftUI

struct Category: Codable, Hashable, Identifiable{
    let name: String
    let id: Int
}

struct Product: Codable, Hashable, Identifiable, Equatable{
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let name: String
    let id: Int
    let price: Int
    let description: String?
    let currency: String
    let user: User?
    let dateTime: String
}

struct User: Codable, Equatable{
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
    let id: Int
    let name: String
    let username: String
    let password: String
    let address: String
    let email: String
}


struct OrderProduct: Codable, Hashable, Identifiable, Equatable{
    static func == (lhs: OrderProduct, rhs: OrderProduct) -> Bool {
        return lhs.invoice == rhs.invoice && lhs.product == rhs.product
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id : Int
    var quantity : Int
    let invoice: Invoice?
    let product : Product?
}

struct Invoice: Codable, Hashable{
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id : Int
    let amount : Int
    let orderProducts : [OrderProduct]?
    let user: User?
}

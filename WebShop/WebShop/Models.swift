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

struct Products: Codable{
    let products: [Product]
}

struct Product: Codable, Hashable, Identifiable{
    let name: String
    let id: Int
    let price: Int
    let description: String?
    let currency: String
    let userId: Int
    let dateTime: String
}

struct User: Codable{
    let name: String
    let username: String
    let password: String
    let address: String
    let email: String
}


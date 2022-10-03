//
//  Models.swift
//  WebShop
//
//  Created by Tóth Keve András on 2022. 10. 03..
//

import Foundation
import SwiftUI

struct Product: Codable, Hashable{
    let name: String
    let id: Int
    let price: Int
    let description: String
    let currency: String
    let companyid: Int
}

struct User: Codable{
    let name: String
    let username: String
    let password: String
    let address: String
    let email: String
}

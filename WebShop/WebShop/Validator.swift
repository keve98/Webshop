//
//  Validator.swift
//  WebShop
//
//  Created by Tóth Keve András on 2022. 10. 06..
//

import Foundation

extension String{
    var isValidEmail: Bool {
            NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
        }
}

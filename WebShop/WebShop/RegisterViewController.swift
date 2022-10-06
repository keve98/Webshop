//
//  RegisterViewController.swift
//  WebShop
//
//  Created by Tóth Keve András on 2022. 10. 05..
//

import Foundation
import UIKit
import SwiftValidator
import SwiftUI

class RegisterViewController: UIViewController, ValidationDelegate{
    
    
    
    let validator = Validator()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func validationSuccessful() {
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        for (field, error) in errors {
            if let field = field as? UITextField {
              field.layer.borderColor = UIColor.red.cgColor
              field.layer.borderWidth = 1.0
            }
            error.errorLabel?.text = error.errorMessage // works if you added labels
            error.errorLabel?.isHidden = false
            error.errorLabel?.textColor = UIColor.red
          }
    }
    
    
    
    
    
}

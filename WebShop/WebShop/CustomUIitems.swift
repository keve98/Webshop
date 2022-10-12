//
//  CustomUIitems.swift
//  WebShop
//
//  Created by Tóth Keve András on 2022. 10. 11..
//

import Foundation
import SwiftUI

struct EntryField: View{
    var placeHolder: String
    var prompt: String
    @Binding var field:String
    var isSecure:Bool = false
    
    var body: some View{
        VStack(alignment: .leading){
            Text(prompt)
                .fixedSize(horizontal: false, vertical: true)
                .font(.caption)
                .foregroundColor(Color.red)
            HStack{
                if(isSecure){
                    SecureField(placeHolder, text: $field)
                        .padding()
                        .cornerRadius(5)
                        .padding(.bottom, 5)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }else{
                    TextField(placeHolder, text: $field)
                        .padding()
                        .cornerRadius(5)
                        .padding(.bottom, 5)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
            }.overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
        }
        
    }
}

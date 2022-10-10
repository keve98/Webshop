//
//  Register.swift
//  WebShop
//
//  Created by Tóth Keve András on 2022. 10. 03..
//

import SwiftUI

struct RegisterView: View {
    
    @ObservedObject var validator = RegisterValidator()
    @ObservedObject var server = ServerCommunication()
    
    @State var registerSuccess = false
    
    @Binding var isShow: Bool


    var body: some View{
        ZStack(alignment: .topLeading) {
            
            Rectangle()
                .fill(Color("bgColor"))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            register
            
            Button(action: {
                self.isShow.toggle()
            }, label: {})
            
        }
    }
    
    var register: some View {
        ZStack {
            VStack {
                Text("REGISTER")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                Text("Create an account")
                    .foregroundColor(.gray)
                

                EntryField(placeHolder: "Name", prompt: validator.confirmNamePrompt, field: $validator.name)
                
                EntryField(placeHolder: "Username", prompt: validator.confirmUsernamePrompt, field: $validator.username)
                
                EntryField(placeHolder: "Address", prompt: validator.confirmAddressPrompt, field: $validator.address)
                
                EntryField(placeHolder: "Email", prompt: validator.emailPrompt, field: $validator.email)
                
                EntryField(placeHolder: "Password", prompt: validator.passwordPrompt, field: $validator.password, isSecure: true)
                
                EntryField(placeHolder: "Confirm password", prompt: validator.confirmPwPrompt, field: $validator.confirmPassword, isSecure: true)
                    
               
                
                HStack {
                    Button(action: {
                        if(validator.isSignUpComplete){
                            registerSuccess = server.registerUser(Name: validator.name, Username: validator.username, Password: validator.password, Address: validator.address, Email: validator.email)
                        }
                    }, label: {
                    })
                    .padding(.top, 10)
                    .buttonStyle(GrowingButtonStyle(buttonText: "CONFIRM"))
                }.padding(.bottom, 15)                
            }.padding(30)
        }
    }
    
    
    
}

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

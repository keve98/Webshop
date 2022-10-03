//
//  Register.swift
//  WebShop
//
//  Created by Tóth Keve András on 2022. 10. 03..
//

import SwiftUI

struct Register: View {
    
    @State var name = ""
    @State var username = ""
    @State var address = ""
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
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
                
                TextField("Name", text: $name)
                    .padding()
                    .cornerRadius(5)
                    .modifier(InnerShadowViewModifier())
                    .padding(.bottom, 20)
                
                TextField("Username", text: $username)
                    .padding()
                    .cornerRadius(5)
                    .modifier(InnerShadowViewModifier())
                    .padding(.bottom, 20)
                
                TextField("Address", text: $address)
                    .padding()
                    .cornerRadius(5)
                    .modifier(InnerShadowViewModifier())
                    .padding(.bottom, 20)
                
                TextField("Email", text: $email)
                    .padding()
                    .cornerRadius(5)
                    .modifier(InnerShadowViewModifier())
                    .padding(.bottom, 20)
                
                SecureField("Password", text: $password)
                    .padding()
                    .cornerRadius(5)
                    .modifier(InnerShadowViewModifier())
                    .padding(.bottom, 10)
                
                SecureField("Confirm password", text: $confirmPassword)
                    .padding()
                    .cornerRadius(5)
                    .modifier(InnerShadowViewModifier())
                    .padding(.bottom, 10)
                
                
                
                HStack {
                    Button(action: {
                        registerUser()
                    }, label: {
                        Spacer()
                        Text("CONFIRM")
                            .fontWeight(.bold)
                            
                        Spacer()
                    })
                    .foregroundColor(Color.black.opacity(0.8))
                    .padding()
                    .background(Color("bgColor"))
                    .cornerRadius(10)
                    .modifier(ShadowViewModifier())
                }.padding(.bottom, 15)                
            }.padding(30)
        }
    }
    
    
    func registerUser(){
        guard let url = URL(string:"http://localhost:8080/save")else{
            print("Not found url")
            return
        }
        
        let newUser = User(name: name, username: username, password: password, address: address, email: email)
        let json = try! JSONEncoder().encode(newUser)
        print(json)
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.httpBody = json
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
       URLSession.shared.dataTask(with: request){
           data, response, error in
            
            
            if let data = data{
            do{
                let result = try JSONDecoder().decode([User].self, from: data)
                DispatchQueue.main.async {
                    print(result)
                }
                
            }
            catch{
                print(error)
            }            }
        }.resume()
        
    }
}

//
//  Login.swift
//  WebShop
//
//  Created by Tóth Keve András on 2022. 10. 03..
//

import SwiftUI

struct Login: View {
    @State var username = ""
    @State var password = ""
    @State var showingAlertSuccess = false
    @State var showingAlertFail = false
    @State var loginError = ""
    @Binding var isShow: Bool

    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color("bgColor"))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Text("WELCOME")
                    .font(.largeTitle)
                    .fontWeight(.semibold)

                Text("Log in to your account")
                    .foregroundColor(.gray)
                
                /*TextField("Username", text: $username)
                    .padding()
                    .cornerRadius(5)
                    .modifier(InnerShadowViewModifier())
                    .padding(.bottom, 20)*/
                
                EntryField(placeHolder: "Username", prompt: "", field: $username)
                EntryField(placeHolder: "Password", prompt: "", field: $password, isSecure: true)
                
               /* SecureField("Password", text: $password)
                    .padding()
                    .cornerRadius(5)
                    .modifier(InnerShadowViewModifier())
                    .padding(.bottom, 10)*/
                
                
                HStack {
                    Spacer()
                    Text("Forget password?")
                        .foregroundColor(.gray)
                }.padding(.bottom, 15)
                
                HStack {
                    Button(action: {
                        login()
                    }, label: {
                        Spacer()
                        Text("LOGIN")
                            .fontWeight(.bold)
                            
                        Spacer()
                    })
                    .foregroundColor(Color.black.opacity(0.8))
                    .padding()
                    .background(Color("bgColor"))
                    .cornerRadius(10)
                    .modifier(ShadowViewModifier())
                    .alert("Output", isPresented: $showingAlertSuccess){
                        Button("OK", role: .cancel){}
                    }message:{
                        Text("Login Successful")
                    }
                    .alert("Output", isPresented: $showingAlertFail){
                        Button("OK", role: .cancel){}
                    }message:{
                        Text(loginError)
                    }
                }.padding(.bottom, 15)
                
                HStack {
                    Text("Sign up")
                        .foregroundColor(.blue)
                        .onTapGesture {
                            self.isShow.toggle()
                        }
                }
                
                Spacer()
            }.padding(30)
        }
    }
    
    func login(){
        guard let url = URL(string:"http://localhost:8080/login")else{
            print("Not found url")
            return
        }
        
        let newUser = User(name: "", username: username, password: password, address: "", email: "")
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
                let result = try JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async {
                    print(result)
                }
                
                showingAlertSuccess = true
                
            }
            catch{
                print(error)
                loginError = response.debugDescription
                showingAlertFail = true
            }
            }
        }.resume()
    }
    
    
    func CheckMandatoryFields(){
        //TODO implement
    }
    
}

struct InnerShadowViewModifier: ViewModifier{
    @State var radius: CGFloat = 5
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: radius)
                    .stroke(Color("bgColor"), lineWidth: 4)
                    .shadow(color: Color("darkShadow"), radius: 4, x: 5, y: 5)
                    .clipShape(RoundedRectangle(cornerRadius: radius))
                    .shadow(color: Color("lightShadow"), radius: 4, x: -5, y: -5)
                    .clipShape(RoundedRectangle(cornerRadius: radius))
            )
            
            
    }
}

struct InnerShadowModifierWrongValidation:ViewModifier{
    @State var radius: CGFloat = 5
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: radius)
                    .stroke(Color.red, lineWidth: 4)
                    .shadow(color: Color.red, radius: 4, x: 5, y: 5)
                    .clipShape(RoundedRectangle(cornerRadius: radius))
                    .shadow(color: Color.red, radius: 4, x: -5, y: -5)
                    .clipShape(RoundedRectangle(cornerRadius: radius))
            )
            
            
    }
}


struct ShadowViewModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .shadow(color: Color("lightShadow"), radius: 5, x: -2, y: -2)
            .shadow(color: Color("darkShadow"), radius: 5, x: 8, y: 8)
    }
}

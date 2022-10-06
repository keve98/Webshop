//
//  Login.swift
//  WebShop
//
//  Created by Tóth Keve András on 2022. 10. 03..
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var validator = LoginValidator()
    
    @State var showingAlertSuccess = false
    @State var showingAlertFail = false
    @State var loginError = ""
    @Binding var isShow: Bool

    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Text("WELCOME")
                    .font(.largeTitle)
                    .fontWeight(.semibold)

                Text("Log in to your account")
                    .foregroundColor(.gray)
            
                
                EntryField(placeHolder: "Username", prompt: validator.usernamePrompt, field: $validator.username)
                EntryField(placeHolder: "Password", prompt: validator.passwordPrompt, field: $validator.password, isSecure: true)
                
                
                
                HStack {
                    Spacer()
                    Text("Forget password?")
                        .foregroundColor(.gray)
                }.padding(.bottom, 15)
                
                HStack {
                    Button(action: {
                        if validator.isLoginComplete{
                        login()
                        }
                    }, label: {

                    })
                    .buttonStyle(GrowingButtonStyle(buttonText: "LOGIN"))
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
        
        let newUser = User(name: "", username: validator.username, password: validator.password, address: "", email: "")
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
}




struct GrowingButtonStyle: ButtonStyle {
    @State var buttonText = ""
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        Text(buttonText)
            .font(.headline)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue
            .cornerRadius(10)
            .shadow(radius: 10))
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

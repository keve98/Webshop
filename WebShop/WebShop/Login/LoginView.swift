//
//  Login.swift
//  WebShop
//
//  Created by Tóth Keve András on 2022. 10. 03..
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var validator = LoginValidator()
    @ObservedObject var server = ServerCommunication()
    
    @State var showingAlertSuccess = false
    @State var showingAlertFail = false
    @State var loginSuccess = false
    @State var active: Bool = false
    @Binding var isShow: Bool
    
    
    var body: some View {
        GeometryReader{geometry in
        NavigationLink(destination: HomePageView(),
                       isActive: self.$active,
                       label: {
                        Text("")}).hidden()
        ZStack {
                Color("bgColor")
                    .ignoresSafeArea(.all)
                VStack {
                    Spacer()
                    Text("WELCOME")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    
                    Text("Log in to your account")
                        .foregroundColor(.gray)
                        .padding(.bottom, 20)
                    
                    
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
                                    server.login(userName: validator.username, pw: validator.password, completion: {
                                        (value) in
                                            self.active = value
                                    })
                                }
                            }, label: {
                            })
                            .buttonStyle(GrowingButtonStyle(buttonText: "LOGIN"))
                        
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
            .background(Color("buttonColor")
                .cornerRadius(10)
                .shadow(radius: 10))
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

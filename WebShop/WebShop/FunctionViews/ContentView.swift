//
//  ContentView.swift
//  WebShop
//
//  Created by Tóth Keve András on 2022. 10. 03..
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
        //HomePageView()
    }
}

struct Home: View{
    @State var isShow = false
    
    var body: some View{
        NavigationView{
            ZStack{
                NavigationLink(
                    destination: RegisterView(isShow: self.$isShow),
                    isActive: self.$isShow,
                    label: {
                        Text("")
                    }).hidden()
                
                LoginView(isShow: self.$isShow)
            }.navigationBarTitle("")
                .navigationBarHidden(true)
        }.navigationBarTitle("")
            .navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

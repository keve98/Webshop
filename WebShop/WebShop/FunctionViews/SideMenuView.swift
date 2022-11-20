//
//  SideMenuView.swift
//  WebShop
//
//  Created by Tóth Keve András on 2022. 10. 12..
//

import SwiftUI

struct SideMenuView: View {
    
    let logoutAction: () -> Void
    let navigateToProfileAction: () -> Void
    let navigateToNewItem: () -> Void
    let navigateToPreviousOrders: () -> Void
    
    var body: some View {
        NavigationView{
        VStack(alignment: .leading) {
            HStack {
                Button(action: navigateToNewItem, label: {
                    Image(systemName: "plus")
                        .foregroundColor(.black)
                        .imageScale(.large)
                    Text("Sell product")
                           .foregroundColor(.black)
                           .font(.headline)
                }).padding([.leading, .top, .trailing])
                
            }
            HStack {
                Button(action: navigateToProfileAction, label: {
                    Image(systemName: "person")
                        .foregroundColor(.black)
                        .imageScale(.large)
                    Text("Profile")
                           .foregroundColor(.black)
                           .font(.headline)
                }).padding([.leading, .top, .trailing])
                    .padding(.bottom, 5)
                
            }
            
            HStack{
                Button(action: navigateToPreviousOrders, label: {
                    Image(systemName: "doc")
                        .foregroundColor(.black)
                        .imageScale(.large)
                    Text("Previous orders")
                        .foregroundColor(.black)
                        .font(.headline)
                }).padding([.leading, .top, .trailing])
                    
            }
            
            HStack {
                    Button(action: logoutAction, label: {
                        Image(systemName: "arrow.backward.square")
                            .foregroundColor(.black)
                            .imageScale(.large)
                        Text("Logout")
                               .foregroundColor(.black)
                               .font(.headline)
                    }).padding([.leading, .top, .trailing])
                       
            }
            Spacer()
        }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color("bgColor"))
            .navigationTitle("")
            .navigationBarHidden(true)
    }
}
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(logoutAction: {}, navigateToProfileAction: {}, navigateToNewItem: {}, navigateToPreviousOrders: {})
    }
}

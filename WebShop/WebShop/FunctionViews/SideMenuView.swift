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
    
    var body: some View {
        NavigationView{
        VStack(alignment: .leading) {
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
            
            HStack {
                    Button(action: logoutAction, label: {
                        Image(systemName: "arrow.backward.square")
                            .foregroundColor(.black)
                            .imageScale(.large)
                        Text("Logout")
                               .foregroundColor(.black)
                               .font(.headline)
                    }).padding([.leading, .bottom, .trailing])
                        .padding(.top, 5)
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
        SideMenuView(logoutAction: {}, navigateToProfileAction: {})
    }
}
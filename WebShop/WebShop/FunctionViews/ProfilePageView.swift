//
//  ProfilePageView.swift
//  WebShop
//
//  Created by Tóth Keve András on 2022. 10. 20..
//

import SwiftUI

struct ProfilePageView: View {
    var body: some View {
        
        ZStack{
            Rectangle()
                .fill(Color("bgColor"))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(ServerCommunication.loggedInUser.name)
                    .font(.custom("AmericanTypewriter", size: 20))
                    .fontWeight(.semibold)
                
            
            
            Spacer().frame(height: 30)
            
            VStack(alignment: .leading, spacing: 12){
                HStack{
                    Image(systemName: "envelope")
                    Text(ServerCommunication.loggedInUser.email)
                }
                HStack{
                    Image(systemName: "house")
                    Text(ServerCommunication.loggedInUser.address)
                }
            }
            
            Spacer().frame(height: 30)
            
                Button(action: {}, label: {
                    
                }).buttonStyle(GrowingButtonStyle(buttonText: "Update Profile"))
                
            }
        }
    
    }
}

struct ProfilePageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePageView()
    }
}

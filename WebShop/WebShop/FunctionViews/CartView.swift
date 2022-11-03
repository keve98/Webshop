//
//  CartView.swift
//  WebShop
//
//  Created by Tóth Keve András on 2022. 10. 28..
//

import SwiftUI

struct CartView: View {
    
    @State var server = ServerCommunication()
    
    @Binding var cartItems : [OrderProduct]
    @State var navigateToHome = false
    
    var body: some View {
        NavigationLink(
            destination: HomePageView(cartItems: self.cartItems),
            isActive: self.$navigateToHome,
            label: {
                Text("")
            }).hidden()
        ZStack{
            Color("bgColor")
                .ignoresSafeArea(.all)
            
            VStack{
                Text("In your cart")
                    .font(.custom("AmericanTypewriter", size: 30))
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.leading, .top])
                VStack{
                ScrollView{
                    VStack{
                        ForEach(cartItems, id: \.self){orderProduct in
                            HStack{
                                ProductListViewImage(imageName: "product")
                                Text(orderProduct.product.name)
                                    .font(.custom("AmericanTypewriter", size: 14))
                                    .fontWeight(.medium)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding([.leading])
                                Text(String(orderProduct.quantity) + " pcs")
                                    .font(.custom("AmericanTypewriter", size: 14))
                                    .fontWeight(.medium)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text(orderProduct.product.currency + " " + String(orderProduct.product.price * orderProduct.quantity) )
                                    .font(.custom("AmericanTypewriter", size: 14))
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding([.trailing])
                            }
                            Color("buttonColor")
                                .frame(width: .infinity, height: 2)
                                .clipShape(Capsule())
                        }.padding([.leading, .trailing], 6)
                    }
                }
                    Button(action: {
                        var amount = 0
                        for orderProduct in cartItems{
                            amount += orderProduct.product.price * orderProduct.quantity
                        }
                        server.saveInvoice(user: ServerCommunication.loggedInUser, amount: amount)
                    }){
                        Text("Buy")
                            .foregroundColor(Color.white)
                            .font(.custom("AmericanTypewriter", size: 16))
                            .padding()
                            .background(Color("buttonColor"))
                            .cornerRadius(10)
                    }
                    HStack{
                        ButtonNavBarItem(imageName: "home", action: {
                            withAnimation{
                                self.navigateToHome.toggle()
                            }
                        }, foregroundColor: Color.white)
                        ButtonNavBarItem(imageName: "cart", action: {}, foregroundColor: Color("buttonColor"))
                    }   .background(Color.white)
                        .clipShape(Capsule())
                        .padding(.horizontal)
                        .shadow(color: Color.black.opacity(0.15), radius: 8, x: 2, y: 6)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                    
                    
                }
            }
        }.background(Color("bgColor"))
            .navigationTitle("")
            .navigationBarHidden(true)
    }
}

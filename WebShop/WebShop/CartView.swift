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
    @State var navigateToRecentProducts = false
    @State var invoice : Invoice?
    
    @State var totalAmount = 0;
    
    var body: some View {
        GeometryReader{geometry in
            NavigationLink(
                destination: HomePageView(cartItems: self.cartItems),
                isActive: self.$navigateToHome,
                label: {
                    Text("")
                }).hidden()
            NavigationLink(
                destination: MostRecentOrdersView(cartItems: self.$cartItems),
                isActive: self.$navigateToRecentProducts,
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
                                        Text(orderProduct.product!.name)
                                            .font(.custom("AmericanTypewriter", size: 14))
                                            .fontWeight(.medium)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding([.leading])
                                        Text(String(orderProduct.quantity) + " pcs")
                                            .font(.custom("AmericanTypewriter", size: 14))
                                            .fontWeight(.medium)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        Text(orderProduct.product!.currency + " " + String(orderProduct.product!.price * orderProduct.quantity) )
                                            .font(.custom("AmericanTypewriter", size: 14))
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                            .padding([.trailing])
                                    }
                                    Color("buttonColor")
                                        .frame(width: .infinity, height: 2)
                                        .clipShape(Capsule())
                                }.padding([.leading, .trailing], 6)
                            }
                        }.frame(maxHeight: .infinity, alignment: .top)
                        
                        VStack{
                            HStack{
                                Text("Total amount: ")
                                    .font(.custom("AmericanTypewriter", size: 14))
                                    .fontWeight(.medium)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding([.leading, .top, .bottom])
                                
                                Text(String(self.totalAmount) + " ,-")
                                    .font(.custom("AmericanTypewriter", size: 14))
                                    .fontWeight(.medium)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding([.trailing, .top, .bottom])
                                
                            }
                            Button(action: {
                                
                                if cartItems.count > 0{
                                    var amount = 0
                                    for orderProduct in cartItems{
                                        amount += orderProduct.product!.price * orderProduct.quantity
                                    }
                                    
                                    Task{
                                        server.saveInvoice(user: ServerCommunication.loggedInUser, amount: amount, completion: {
                                            (value) in
                                            for orderProduct in cartItems{
                                                server.saveOrderProduct(quantity: orderProduct.quantity, invoice: value, product: orderProduct.product!)
                                                
                                                cartItems.removeAll()
                                                
                                                self.navigateToHome = true
                                            }
                                        })
                                    }
                                }
                            }){
                                Text("Buy")
                                    .foregroundColor(Color.white)
                                    .font(.custom("AmericanTypewriter", size: 16))
                                    .padding()
                                    .background(Color("buttonColor"))
                                    .cornerRadius(10)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding()
                                
                                
                                
                            }
                            HStack{
                               
                                ButtonNavBarItem(imageName: "cart", action: {}, foregroundColor: Color("buttonColor"))
                                ButtonNavBarItem(imageName: "house", action: {
                                    withAnimation{
                                        self.navigateToHome.toggle()
                                    }
                                }, foregroundColor: Color.white)
                                ButtonNavBarItem(imageName: "heart", action: {
                                    withAnimation{
                                        self.navigateToRecentProducts.toggle()
                                    }
                                }, foregroundColor: Color.white)
                            }   .background(Color.white)
                                .clipShape(Capsule())
                                .padding(.horizontal)
                                .shadow(color: Color.black.opacity(0.15), radius: 8, x: 2, y: 6)
                                .frame(maxHeight: .infinity, alignment: .bottom)
                            
                            
                        }.frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
            
        }.navigationTitle("")
            .navigationBarHidden(true)
            .background(Color("bgColor"))
            .onAppear{
                
                for orderProduct in cartItems{
                    self.totalAmount += orderProduct.quantity * orderProduct.product!.price
                }
                
            }
    }
}

struct CartView_Previews: PreviewProvider {
    
    @State static var cart : [OrderProduct] = []
    static var previews: some View {
        
        CartView(server: ServerCommunication(), cartItems: $cart, navigateToHome: false, invoice: nil)
    }
}

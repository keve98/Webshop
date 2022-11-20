//
//  MostRecentOrdersView.swift
//  WebShop
//
//  Created by Tóth Keve András on 2022. 11. 13..
//

import SwiftUI

struct MostRecentOrdersView: View {
    
    @State var navigateToCart = false
    @State var navigateToHome = false
    @State var navigateToDetailsPage = false
    @State var recentProducts : [Product] = []
    @State var product = Product(name: "", id: 0, price: 0, description: "", currency: "", user: ServerCommunication.loggedInUser, dateTime: "", orderProducts: nil, category: nil)
    @Binding var cartItems : [OrderProduct]
    
    var body: some View {
        GeometryReader{geometry in
            NavigationLink(
                destination: HomePageView(cartItems: self.cartItems),
                isActive: self.$navigateToHome,
                label: {
                    Text("")
                }).hidden()
            NavigationLink(
                destination: ProductDetailsView(product: self.product, cartItems: self.$cartItems),
                isActive: self.$navigateToDetailsPage,
                label: {
                    Text("")
                }).hidden()
            NavigationLink(
                destination: CartView(cartItems: self.$cartItems),
                isActive: self.$navigateToCart,
                label: {
                    Text("")
                }).hidden()
        ZStack{
            Color("bgColor")
                .ignoresSafeArea(.all)
            VStack{
                Text("Most recent ordered products")
                    .font(.custom("AmericanTypewriter", size: 30))
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.leading, .top])
                
                
                
                VStack{
                    ScrollView{
                    ForEach(recentProducts, id: \.self){product in
                        HStack{
                            ProductListViewImage(imageName: "product")
                            Text(product.name)
                                .font(.custom("AmericanTypewriter", size: 14))
                                .fontWeight(.medium)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding([.leading])
                            Text(product.currency + " " + String(product.price) )
                                .font(.custom("AmericanTypewriter", size: 14))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding([.trailing])
                        }.onTapGesture{
                            self.product = product
                            self.navigateToDetailsPage.toggle()
                        }
                        Color("buttonColor")
                            .frame(width: .infinity, height: 2)
                            .clipShape(Capsule())
                    }.padding([.leading, .trailing], 6)
                    }
                }
                .padding(.bottom, 5)
                .onAppear{
                    ServerCommunication().getMostRecentProductsForUser(user: ServerCommunication.loggedInUser, completion: {(recentProds) in
                        self.recentProducts = recentProds
                    })
                }
                
            
            HStack{
               
                ButtonNavBarItem(imageName: "cart", action: {
                    withAnimation{
                        self.navigateToCart.toggle()}
                }, foregroundColor: Color.white)
                ButtonNavBarItem(imageName: "house", action: {
                    withAnimation{
                        self.navigateToHome.toggle()
                    }
                }, foregroundColor: Color.white)
                ButtonNavBarItem(imageName: "heart", action: {}, foregroundColor: Color("buttonColor"))
            }   .background(Color.white)
                .clipShape(Capsule())
                .padding(.horizontal)
                .shadow(color: Color.black.opacity(0.15), radius: 8, x: 2, y: 6)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }.background(Color("bgColor"))
                .navigationBarTitle("")
                .navigationBarHidden(true)
                
        }
    }
}

struct MostRecentOrdersView_Previews: PreviewProvider {
    @State static var cart : [OrderProduct] = []
    static var previews: some View {
        MostRecentOrdersView(cartItems: self.$cart)
    }
}

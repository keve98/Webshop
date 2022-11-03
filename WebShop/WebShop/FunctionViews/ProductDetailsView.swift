//
//  ProductDetailsView.swift
//  WebShop
//
//  Created by Tóth Keve András on 2022. 10. 22..
//

import SwiftUI

struct ProductDetailsView: View {
    
    let product : Product
    
    
    @Binding var cartItems : [OrderProduct]
    @State var quantity : Int = 1
    
    var body: some View {
        ZStack{
            ScrollView{
                Image("product")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .edgesIgnoringSafeArea(.top)
                
                
                DescriptionView(product: product, quantity: self.$quantity)
                    .offset(y: -40)
                
            }
            
            HStack{
                Text(product.currency + " " + String(product.price))
                    .font(.custom("AmericanTypewriter", size: 26))
                    .fontWeight(.medium)
                    .foregroundColor(Color("bgColor"))
                Spacer()
                
                Button(action: {
                    let op = OrderProduct(id: 0, quantity: self.quantity, invoice: nil, product: self.product)
                    self.cartItems.append(op)
                }, label: {
                    Text("Add to cart")
                        .padding()
                        .padding(.horizontal)
                        .background(Color("bgColor"))
                        .foregroundColor(Color("buttonColor"))
                        .cornerRadius(10.0)
                
                })
            }.padding()
                .padding(.horizontal)
                .background(Color("buttonColor"))
                .cornerRadius(50, corners: .topLeft)
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct RoundedCorner : Shape{
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path{
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View{
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View{
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct DescriptionView: View {
    let product : Product
    @Binding var quantity : Int
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                Text(product.name)
                    .font(.custom("AmericanTypewriter", size: 36))
                    .fontWeight(.bold)
                Text("Description")
                    .font(.custom("AmericanTypewriter", size: 20))
                    .fontWeight(.medium)
                    .padding(.vertical, 8)
                
                Text(product.description!)
                    .padding(.bottom)
                    .font(.custom("AmericanTypeWriter", size: 20))
                    .lineSpacing(8.0)
                    .opacity(0.6)
    
                VStack{
      
                    Text("Quantity")
                        .font(.custom("AmericanTypewriter", size: 20))
                        .fontWeight(.semibold)
                    
                    HStack{
                        Button(action: {
                            if(self.quantity != 1){
                                self.quantity -= 1
                            }
                        }, label: {
                            Image(systemName: "minus")
                                .padding(.all, 8)
                        }).padding()
                        .frame(width: 30, height: 30)
                            .overlay(RoundedRectangle(cornerRadius: 50).stroke())
                            .foregroundColor(Color("buttonColor"))
                        
                        Text(String(self.quantity))
                            .font(.custom("AmericanTypewriter", size: 20))
                            .fontWeight(.semibold)
                            .padding(.horizontal, 8)
                        
                        Button(action: {
                            self.quantity += 1
                        }, label: {
                            Image(systemName: "plus")
                                .padding(.all, 8)
                        })
                        .background(Color("buttonColor"))
                            .clipShape(Circle())
                            .foregroundColor(Color("bgColor"))
                    }
                    Spacer()
                }
            }.padding()
                .padding(.top)
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .topLeading
                )
                .background(Color("bgColor"))
                .cornerRadius(40.0)
            
        }
        
    }
}

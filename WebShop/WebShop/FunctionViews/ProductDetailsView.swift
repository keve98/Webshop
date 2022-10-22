//
//  ProductDetailsView.swift
//  WebShop
//
//  Created by Tóth Keve András on 2022. 10. 22..
//

import SwiftUI

struct ProductDetailsView: View {
    
    let product : Product
    
    
    var body: some View {
        ZStack{
            ScrollView{
                
                
                Image("product")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .edgesIgnoringSafeArea(.top)
                
                
                DescriptionView(product: product)
                    .offset(y: -40)
                
            }
            
            HStack{
                Text(product.currency + " " + String(product.price))
                    .font(.custom("AmericanTypewriter", size: 26))
                    .fontWeight(.medium)
                    .foregroundColor(Color("bgColor"))
                Spacer()
                
                Button(action: {}, label: {
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

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let p = Product(name: "Banana", id: 0, price: 500, description: "All of the monkeys love banana", currency: "HUF", userId: 0, dateTime: "2022-02-02")
        ProductDetailsView(product: p)
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
    @State var quantity = 1
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
                
                Text(product.description)
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

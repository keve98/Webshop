//
//  PreviousOrderDetailsView.swift
//  WebShop
//
//  Created by Tóth Keve András on 2022. 11. 06..
//

import SwiftUI

struct PreviousOrderDetailsView: View {
    
    @State var invoice : Invoice?
    @State var orderproducts: [OrderProduct]
    @State var products: [Product]
    
    var body: some View {
        ZStack{
            Color("bgColor")
                .ignoresSafeArea(.all)
            
            VStack{
                ScrollView{
                    VStack{
                        ForEach(orderproducts, id: \.self){op in
                            HStack{
                                ProductListViewImage(imageName: "product")
                                VStack{
                                    Text(op.product!.name)
                                        .font(.custom("AmericanTypewriter", size: 14))
                                        .fontWeight(.medium)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding([.leading])
                                    
                                    HStack{
                                        
                                        Text(String(op.quantity))
                                            .font(.custom("AmericanTypewriter", size: 20))
                                            .fontWeight(.semibold)
                                            .padding(.horizontal, 8)
                                        
                                        
                                        Text(op.product!.currency + " " + String(op.product!.price * op.quantity) )
                                            .font(.custom("AmericanTypewriter", size: 14))
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                            .padding([.trailing])
                                    }
                                    
                                }
                            }
                        }
                    }
                }
                VStack{
                    HStack{
                        Text("Total amount: ")
                            .font(.custom("AmericanTypewriter", size: 14))
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.leading, .top, .bottom])
                        
                        Text(String(self.invoice!.amount) + " ,-")
                            .font(.custom("AmericanTypewriter", size: 14))
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding([.trailing, .top, .bottom])
                        
                    }
                }
            }
            
        }
    }
}

struct PreviousOrderDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PreviousOrderDetailsView(orderproducts: [], products: [])
    }
}

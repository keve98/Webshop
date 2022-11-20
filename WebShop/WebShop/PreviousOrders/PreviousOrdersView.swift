//
//  PreviousOrdersView.swift
//  WebShop
//
//  Created by Tóth Keve András on 2022. 10. 30..
//

import SwiftUI

struct PreviousOrdersView: View {
    
    @State var previousOrders : [Invoice] = []
    
    @State var order : Invoice? = nil
    @State var orderproducts: [OrderProduct] = []
    @State var products: [Product] = []
    
    @State var navigateToOrderDetailsPage = false
    
    var body: some View {
        NavigationLink(
            destination: PreviousOrderDetailsView(invoice: order, orderproducts: orderproducts, products: products),
            isActive: self.$navigateToOrderDetailsPage,
            label: {
                Text("")
            }).hidden()
        ZStack{
            Color("bgColor")
                .ignoresSafeArea(.all)
            
            VStack{
                Text("Previous orders")
                    .font(.custom("AmericanTypewriter", size: 30))
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.leading, .top])
                VStack{
                    ScrollView{
                        VStack{
                            ForEach(previousOrders, id: \.self){previousOrder in
                                HStack{
                                    ProductListViewImage(imageName: "product")
                                    Text("Paid")
                                        .font(.custom("AmericanTypewriter", size: 14))
                                        .fontWeight(.medium)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding([.leading])
                                    Text(String(previousOrder.orderProducts!.count) + "pcs")
                                        .font(.custom("AmericanTypewriter", size: 14))
                                        .fontWeight(.medium)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text(String(previousOrder.amount) + ",-")
                                        .font(.custom("AmericanTypewriter", size: 14))
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .padding([.trailing])
                                }.onTapGesture{
                                    self.order = previousOrder
                                    Task{
                                        ServerCommunication().getOrderProductsForInvoice(invoice: self.order!, completion: {(ops) in
                                            self.orderproducts = ops
                                        })
                                        
                                        ServerCommunication().getProductsForInvoice(invoice: self.order!, completion: {
                                            (ps) in
                                            self.products = ps
                                        })
                                    }
                                    
                                    for var op in self.orderproducts{
                                        for p in self.products{
                                            for op_t in p.orderProducts!{
                                                if op_t.id == op.id{
                                                    op.product = p
                                                    print(op)
                                                }
                                            }
                                        }
                                        
                                        
                                    }
                                    self.navigateToOrderDetailsPage.toggle()
                                }
                            }
                        }
                    }
                }
            }
        }.background(Color("bgColor"))
            .navigationBarTitle("")
            .onAppear{
                ServerCommunication().getInvoicesForUser(user: ServerCommunication.loggedInUser, completion: {(previousOrders) in
                    self.previousOrders = previousOrders
                })
            }
    }
}

struct PreviousOrdersView_Previews: PreviewProvider {
    static var previews: some View {
        PreviousOrdersView()
    }
}

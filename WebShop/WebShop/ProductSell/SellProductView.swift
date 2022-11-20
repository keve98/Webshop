//
//  SellProductView.swift
//  WebShop
//
//  Created by Tóth Keve András on 2022. 11. 20..
//

import SwiftUI

struct SellProductView: View {
    @ObservedObject var validator = SellProductValidator()
    @ObservedObject var server = ServerCommunication()
    
    @State var productAddSuccess = false
    
    @State var categories : [Category]
    
    @State var filteredCategories : [Category] = []
    
    @State var selectedCategory : Category? = nil
    


    var body: some View{
        ZStack(alignment: .topLeading) {
            
            Rectangle()
                .fill(Color("bgColor"))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            
            addProduct
            
            
        }
    }
    
    var addProduct: some View {
        ZStack {
            VStack {
                Text("Sell product")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding()
                
                

                EntryField(placeHolder: "Name", prompt: validator.confirmNamePrompt, field: $validator.name)
                
                EntryField(placeHolder: "Price", prompt: validator.confirmPricePrompt, field: $validator.price)
                
                EntryField(placeHolder: "Description", prompt: "", field: $validator.description)
                
                Text("Choose category")
                Picker("Choose category", selection: $selectedCategory){
                    ForEach(filteredCategories){ category in
                        Text(category.name)
                    }
                }.pickerStyle(.wheel)
                
                
                HStack {
                    Button(action: {
                        if(validator.isNewProductComplete){
                            let newProduct = Product(name: validator.name, id: 0, price: Int(validator.price)!, description: validator.description, currency: "HUF", user: ServerCommunication.loggedInUser, dateTime: "", orderProducts: nil, category: selectedCategory)
                            
                            server.saveProduct(product: newProduct)
                        }
                    }, label: {
                    })
                    .padding(.top, 10)
                    .buttonStyle(GrowingButtonStyle(buttonText: "CONFIRM"))
                }.padding(.bottom, 15)
            }.padding(30)
        }.onAppear{
            for c in categories{
                if c.name != "All"{
                    filteredCategories.append(c)
                }
            }
            selectedCategory = filteredCategories[0]
        }
    }
}

struct SellProductView_Previews: PreviewProvider {
    static var previews: some View {
        SellProductView(categories: [])
    }
}

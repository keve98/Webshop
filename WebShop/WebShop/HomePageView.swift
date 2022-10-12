//
//  HomePageView.swift
//  WebShop
//
//  Created by Tóth Keve András on 2022. 10. 06..
//

import SwiftUI

struct HomePageView: View {
    static var server = ServerCommunication()
    
    @State var products: [Product] = []
    @State var categories: [Category] = []
    @State private var selectedCategoryIndex: Int = 1
    
    
    var body: some View {
        ZStack{
            Color("bgColor")
                .ignoresSafeArea(.all)
            
            VStack(alignment: .leading){
                
                AppBarView()
                TagLineView().padding()
                SearchBarView()
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(categories, id: \.self){category in
                            CategoryView(isActive: category.id == selectedCategoryIndex, text: category.name)
                                .onTapGesture {
                                    self.products = []
                                    selectedCategoryIndex = category.id
                                    if category.id == 1{
                                        ServerCommunication().getAllProducts{(products) in
                                            self.products = products
                                        }
                                        
                                    }                            else{ServerCommunication().getProductsForCategory(categoryid: selectedCategoryIndex, completion: {(products) in
                                            self.products = products
                                        })}
                                    }
                                }
                        }.padding().onAppear{
                            ServerCommunication().getAllCategories{(categories) in
                                self.categories = categories
                                
                            }
                        }
                    }
                ScrollView{
                    Text("News")
                        .font(.custom("AmericanTypewriter", size: 22))
                        .fontWeight(.medium)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            VStack{
                                Text("Item1")
                                Text("price1")
                            }.padding()
                            VStack{
                                Text("Item1")
                                Text("price1")
                            }.padding()
                            VStack{
                                Text("Item1")
                                Text("price1")
                            }.padding()
                            VStack{
                                Text("Item1")
                                Text("price1")
                            }.padding()
                            VStack{
                                Text("Item1")
                                Text("price1")
                            }.padding()
                            VStack{
                                Text("Item1")
                                Text("price1")
                            }.padding()
                        }
                    }
                    Spacer()
                    
                        VStack{
                            ForEach(products, id: \.self){product in
                                HStack{
                                    Text(product.name)
                                        .font(.custom("AmericanTypewriter", size: 18))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text(String(product.price) + " " + product.currency)
                                        .font(.custom("AmericanTypewriter", size: 18))
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                                Color("buttonColor")
                                    .frame(width: .infinity, height: 2)
                                    .clipShape(Capsule())
                            }.padding([.leading, .top, .trailing])
                            
                        }
                        .onAppear{
                            ServerCommunication().getAllProducts{(products) in
                                self.products = products
                            }
                        }
                        Spacer()
                    }
                }.navigationBarBackButtonHidden(true)
            }
        }
        
        struct AppBarView : View{
            var body: some View{
                HStack{
                    Button(action: {}){
                        Image("menu")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding()
                            .background(Color("buttonColor"))
                            .cornerRadius(10)
                    }
                    Spacer()
                    Text(ServerCommunication.loggedInUser.name)
                        .font(.custom("AmericanTypewriter", size: 16))
                }
                .padding(.horizontal)
            }
        }
    }
    
    struct TagLineView:View{
        var body: some View{
            Text("Find the best products!")
                .font(.custom("AmericanTypewriter", size: 28))
        }
    }
    
    struct SearchBarView : View {
        @State private var search: String = ""
        
        var body: some View{
            HStack{
                Image("search")
                    .padding(.trailing, 8)
                TextField("Search product", text: $search)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10.0)
            .padding(.horizontal)
        }
    }
    
    struct CategoryView : View{
        let isActive: Bool
        let text: String
        var body: some View{
            VStack(alignment: .leading, spacing: 0){
                Text(text)
                    .font(.custom("AmericanTypewriter", size: 14))
                    .fontWeight(.medium)
                    .foregroundColor(isActive ? Color.black: Color.brown.opacity(10))
                
                if(isActive){
                    Color("buttonColor")
                        .frame(width: 15, height: 2)
                        .clipShape(Capsule())
                }
            }
            
            .padding(.trailing)
        }
    }
    
    struct HomePageView_Previews: PreviewProvider {
        static var previews: some View {
            HomePageView()
        }
    }
    
    

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
    @State var news: [Product] = []
    @State var categories: [Category] = []
    @State var cartItems: [OrderProduct] = []
    @State private var allItemsCategoryIndex: Int = 4
    @State private var selectedCategoryIndex: Int = 4
    @State private var search: String = ""
    
    @State var showMenu = false
    @State var navigateToLogout = false
    @State var navigateToProfile = false
    @State var navigateToDetailsPage = false
    @State var navigateToCart = false
    @State var navigateToPreviousOrders = false
    @State var navigateToMostRecentProducts = false
    @State var navigateToSellProduct = false
    
    @State var product = Product(name: "", id: 0, price: 0, description: "", currency: "", user: ServerCommunication.loggedInUser, dateTime: "", orderProducts: nil, category: nil)
    
    var body: some View {
        GeometryReader{geometry in
                NavigationLink(
                    destination: Home(),
                    isActive: self.$navigateToLogout,
                    label: {
                        Text("")
                    }).hidden()
                NavigationLink(
                    destination: ProfilePageView(),
                    isActive: self.$navigateToProfile,
                    label: {
                        Text("")
                    }).hidden()
            NavigationLink(
                destination: ProductDetailsView(product: product, cartItems: self.$cartItems),
                isActive: self.$navigateToDetailsPage,
                label: {
                    Text("")
                }).hidden()
            NavigationLink(
                destination: CartView(cartItems: self.$cartItems, invoice: nil),
                isActive: self.$navigateToCart,
                label: {
                    Text("")
                }).hidden()
            NavigationLink(
                destination: PreviousOrdersView(),
                isActive: self.$navigateToPreviousOrders,
                label: {
                Text("")
            }).hidden()
            NavigationLink(
                destination: MostRecentOrdersView(cartItems: $cartItems),
                isActive: self.$navigateToMostRecentProducts,
                label: {
                Text("")
            }).hidden()
            NavigationLink(
                destination: SellProductView(categories: categories),
                isActive: self.$navigateToSellProduct,
                label: {
                Text("")
            }).hidden()
            ZStack(alignment: .leading){
                    
                    Color("bgColor")
                        .ignoresSafeArea(.all)
                    
                    VStack(alignment: .leading){
                        
                        AppBarView(action: {
                            withAnimation{
                            self.showMenu.toggle()
                            }
                        })
                        TagLineView().padding()
                        
                        //SEARCH BAR VIEW
                        
                            HStack{
                                Button(action: {
                                    self.products = []
                                    if selectedCategoryIndex == allItemsCategoryIndex{
                                        ServerCommunication().getAllProductsBySearchString(str: self.search, completion: {
                                            (products) in
                                            self.products = products
                                        })
                                    }else{
                                        ServerCommunication().getAllProductsBySearchStringAndCategory(str: self.search, categoryid: self.selectedCategoryIndex, completion: {
                                            (products) in
                                            self.products = products
                                        })
                                    }
                                }, label: {
                                    Image("search")
                                        .padding(.trailing, 8)
                                })
                                
                                TextField("Search product", text: $search)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10.0)
                            .padding(.horizontal)
                        
                        
                        //CATEGORY LISTVIEW
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                ForEach(categories, id: \.self){category in
                                    CategoryView(isActive: category.id == selectedCategoryIndex, text: category.name)
                                        .onTapGesture {
                                            self.products = []
                                            selectedCategoryIndex = category.id
                                            if category.id == allItemsCategoryIndex{
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
                        
                        
                        //NEWS BAR
                        ScrollView{
                            Text("News")
                                .font(.custom("AmericanTypewriter", size: 22))
                                .fontWeight(.medium)
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack{
                                    
                                    ForEach(news, id: \.self){new in
                                        VStack{
                                            NewProductItemImage(imageName: "product")
                                            
                                            HStack {
                                                Text(new.currency + " " + String(new.price))
                                                    .font(.custom("AmericanTypewriter", size: 14))
                                                    .fontWeight(.medium)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                            }
                                        }.frame(width: 150)
                                            .padding()
                                            .background(Color.white)
                                            .cornerRadius(20.0)
                                    }.padding(.leading)
                                    
                                }.onAppear{
                                    ServerCommunication().getNewProducts{(news) in
                                        self.news = news
                                    }
                                }
                            }.padding(.bottom)
                            Spacer()
                            
                            //PRODUCT LISTVIEW
                            VStack{
                                ForEach(products, id: \.self){product in
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
                            .padding(.bottom, 5)
                            .onAppear{
                                ServerCommunication().getAllProducts{(products) in
                                    self.products = products
                                }
                            }
                            Spacer()
                            
                        }
                        
                        
                        
                    }.navigationBarBackButtonHidden(true)
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                    
                    HStack{
                       
                        ButtonNavBarItem(imageName: "cart", action: {
                            withAnimation{
                                self.navigateToCart.toggle()}
                        }, foregroundColor: Color.white)
                        ButtonNavBarItem(imageName: "house", action: {}, foregroundColor: Color("buttonColor"))
                        ButtonNavBarItem(imageName: "heart", action: {
                            withAnimation{
                                self.navigateToMostRecentProducts.toggle()
                            }
                        }, foregroundColor: Color.white)
                    }   .background(Color.white)
                        .clipShape(Capsule())
                        .padding(.horizontal)
                        .shadow(color: Color.black.opacity(0.15), radius: 8, x: 2, y: 6)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                
                
                
                
                }.frame(width: geometry.size.width, height: geometry.size.height)
                .offset(x: self.showMenu ? geometry.size.width/3 : 0)
            
            if self.showMenu{
                SideMenuView(logoutAction: {
                    HomePageView.server.logout()
                    self.navigateToLogout.toggle()
                    self.showMenu.toggle()
                }, navigateToProfileAction: {
                    self.navigateToProfile.toggle()
                    self.showMenu.toggle()
                }, navigateToNewItem: {
                    self.navigateToSellProduct.toggle()
                    self.showMenu.toggle()
                }, navigateToPreviousOrders: {
                    self.navigateToPreviousOrders.toggle()
                    self.showMenu.toggle()
                }).frame(width: geometry.size.width/3)
            }
            }.background(Color("bgColor"))
                .navigationBarTitle("")
                .navigationBarHidden(true)
        }
}
struct AppBarView : View{
    let action: ()-> Void
    var body: some View{
        HStack{
            Button(action: action){
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

struct TagLineView:View{
    var body: some View{
        Text("Find the best products!")
            .font(.custom("AmericanTypewriter", size: 28))
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

struct NewProductItemImage : View{
    let imageName: String
    
    var body: some View{
        Image(imageName)
            .resizable()
            .frame(width: 110, height: 110)
            .background(Color.white)
            .cornerRadius(20.0)
    }
}

struct ProductListViewImage : View{
    let imageName : String
    
    var body: some View{
        Image(imageName)
            .resizable()
            .frame(width: 30, height: 30)
            .padding()
            .background(Color.white)
            .cornerRadius(10.0)
    }
}

struct ButtonNavBarItem: View{
    let imageName: String
    let action: ()-> Void
    let foregroundColor: Color
    
    var body: some View{
        Button(action: action){
            Image(systemName: imageName)
                .resizable()
                .frame(width: 15, height: 15)
                .frame(maxWidth: .infinity)
                .padding()
                .background(foregroundColor)
                .cornerRadius(10)
                .foregroundColor(Color.black)
                
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}



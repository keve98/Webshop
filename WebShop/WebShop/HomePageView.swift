//
//  HomePageView.swift
//  WebShop
//
//  Created by Tóth Keve András on 2022. 10. 06..
//

import SwiftUI

struct HomePageView: View {
    
    // @State var loggedInUser : User
    private let categories = ["category1", "category2", "category3", "category4", "category5"]
    @State private var selectedCategoryIndex: Int = 0
    
    var body: some View {
        ZStack{
            Color("bgColor")
                .edgesIgnoringSafeArea(.all)
            
            ScrollView{
                VStack(alignment: .leading){
                    AppBarView()
                    TagLineView().padding()
                    SearchBarView()
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            ForEach(0 ..< categories.count) { i in
                                CategoryView(isActive: i == selectedCategoryIndex, text: categories[i])
                                    .onTapGesture {
                                        selectedCategoryIndex = i
                                    }
                            }
                        }
                        .padding()
                    }
                    
                    Text("News")
                        .font(.custom("AmericanTypewriter", size: 22))
                        .fontWeight(.medium)
                        .padding(.horizontal)
                    ScrollView(.horizontal, showsIndicators: false){
                        VStack{
                            Text("Place for new items")
                        }
                    }
                    
                    
                    Text("Products")
                    ProductListView()
                    
                    
                    
                }
            }
        }.navigationBarBackButtonHidden(true)
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

struct ProductListView : View{
    
    @StateObject var server = ServerCommunication()
    
    var body: some View{
        NavigationView{
            List{
                ForEach(server.products, id: \.self) {product in
                    VStack{
                        HStack{
                            Text(product.name)
                            Text(String(product.price) + product.currency)
                        }
                        
                        
                        Text(product.description)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    .padding()
                }
            }
        }.onAppear{server.getAllProducts()}
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}



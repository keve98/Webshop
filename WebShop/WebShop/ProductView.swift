//
//  ProductView.swift
//  WebShop
//
//  Created by Tóth Keve András on 2022. 09. 17..
//

import SwiftUI

struct Product: Hashable, Codable{
    let name: String
    let id: Int
    let price: Int
    let description: String
    let currency: String
    let companyid: Int
}

class ViewModel:ObservableObject{
    
    @Published var products: [Product] = []
    
    func fetch(){
        guard let url = URL(string:
                                "http://localhost:8080/products")else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){
           [weak self] data, response, error in
            
            
            //convert to JSON
            if let data = data{
            do{
                let products = try JSONDecoder().decode([Product].self, from: data)
                DispatchQueue.main.async {
                    self?.products = products
                }
                
            }
            catch{
                print(error)
            }
            }
        }
        
        task.resume()
    }
}

struct ProductView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView{
            List{
                ForEach(viewModel.products, id: \.self) {product in
                    VStack{
                        HStack{
                            Text(product.name)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(String(product.price) + product.currency)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        
                        
                        Text(product.description)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    .padding()
                }
            }
            .navigationTitle("Products")
        }
        .onAppear{
            viewModel.fetch()
        }
    }
}


struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView()
    }
}

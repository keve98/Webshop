//
//  PreviousOrderDetailsView.swift
//  WebShop
//
//  Created by Tóth Keve András on 2022. 11. 06..
//

import SwiftUI

struct PreviousOrderDetailsView: View {
    
    @State var order : Invoice?
    
    
    var body: some View {
        ZStack{
            Color("bgColor")
            .ignoresSafeArea(.all)
            
            VStack{
                ScrollView{
                    VStack{
                    }
                }
            }
            
        }
    }
}

struct PreviousOrderDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PreviousOrderDetailsView()
    }
}

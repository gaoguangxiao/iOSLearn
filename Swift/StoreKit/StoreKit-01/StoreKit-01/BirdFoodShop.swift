//
//  BirdFoodShop.swift
//  StoreKit-01
//
//  Created by 高广校 on 2024/11/6.
//

import SwiftUI
import StoreKit

struct BirdFoodShop: View {
    
    @Query var birdFood: [BirdFoodShop]
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    BirdFoodShop()
}

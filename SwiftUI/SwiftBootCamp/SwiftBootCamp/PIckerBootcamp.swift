//
//  PIckerBootcamp.swift
//  SwiftBootCamp
//
//  Created by 高广校 on 2023/11/20.
//

import SwiftUI

struct PIckerBootcamp: View {
    
    @State var selection : String = "2"
    
    enum Thickness: String, CaseIterable, Identifiable {
        case thin
        case regular
        case thick

       var id: String { rawValue }
    }

    struct Border {
        var color: Color
        var thickness: Thickness
    }

    @State private var selectedObjectBorders = [
        Border(color: .black, thickness: .thin),
        Border(color: .red, thickness: .thick)
    ]

    
    var body: some View {
        
             
//        if #available(iOS 16.0, *) {
//            Picker(
//                sources: $selectedObjectBorders,
//                selection: \.thickness
//            ) {
//                ForEach(Thickness.allCases) { thickness in
//                    Text(thickness.rawValue)
//                }
//            } label: {
//                Text("Border Thickness")
//            }
//        } else {
//            // Fallback on earlier versions
//        }
        
        ///
        Picker(selection: $selection) {
            ForEach((18..<100)) { number in
                Text("file\(number)")
                    .tag("\(number)")
                    .foregroundStyle(.red)
                    .font(.headline)
            }
        } label: {
//            HStack{
                Text("Filter:111111")
//            }
        }
        .pickerStyle(.menu)
        
        
        //        VStack {
        //            Text("Age")
        //            Text(selection)
        //            Picker(selection: $selection) {
        //                ForEach((18..<100)) { number in
        //                    Text("\(number)")
        //                        .tag("\(number)")
        //                        .foregroundStyle(.red)
        //                }
        //            } label: {
        //                HStack{
        //                    Text("Age chose")
        //                }
        //                Text("122")
        //            }
        ////            .pickerStyle(.inline)
        ////            .pickerStyle(.automatic)
        ////            .pickerStyle(.wheel)
        //        }
        
    }
}

#Preview {
    PIckerBootcamp()
}

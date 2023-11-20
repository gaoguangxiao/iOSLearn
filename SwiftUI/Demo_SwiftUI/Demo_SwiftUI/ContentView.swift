//
//  ContentView.swift
//  Demo_SwiftUI
//
//  Created by gaoguangxiao on 2022/4/11.
//

import SwiftUI
import struct Kingfisher.KFImage

struct ContentView: View {
    
    let sceneries = [
        Scenery(id: 1001, name: "金字塔", thumbnailName: "1650448799", imageName: "https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLZQTLUicTZJGjUJPrI8tMGXwvjQEER0RHomI9giapeJsvwd596KnH5BkEtzagnVacXopSY3iaUD3beQ/132", location: "埃及89"),
        Scenery(id: 1002, name: "喜马拉雅", thumbnailName: "1650448799", imageName: "https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLZQTLUicTZJGjUJPrI8tMGXwvjQEER0RHomI9giapeJsvwd596KnH5BkEtzagnVacXopSY3iaUD3beQ/132", location: "埃及2"),
        Scenery(id: 1003, name: "密西西比河", thumbnailName: "1650448799", imageName: "https://picsum.photos/id/200/200/200", location: "埃及3"),
        Scenery(id: 1004, name: "自由女神", thumbnailName: "1650448799", imageName: "https://picsum.photos/id/300/200/200", location: "埃及4"),
        Scenery(id: 1005, name: "莎", thumbnailName: "1650448799", imageName: "https://picsum.photos/id/400/200/200", location: "埃及5")
    ]
    
    @State private var change = false
    
    var body :some View {
        //        List()
        
        NavigationView {
            List(sceneries) { item in
                HStack {
                    KFImage(URL(string: item.imageName))
                        .resizable()
                        .frame(width: 60, height: 60, alignment: .center)
                    VStack (alignment:.leading) {
                        Text(item.name)
                        Text(item.location)
                    }
                    
                    NavigationLink {
                        Text(item.location) //跳转的view
                    } label: {
                        Text("") //连接额描述
                    }
                }

            }
            .navigationBarTitle("名胜古迹")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

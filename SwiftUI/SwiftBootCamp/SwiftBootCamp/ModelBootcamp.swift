//
//  ModelBootcamp.swift
//  SwiftBootCamp
//
//  Created by 高广校 on 2023/11/20.
//

import SwiftUI

//Identifiable 需要为每一个模型添加一个id
struct UserModel: Identifiable {
    let id: String = UUID().uuidString
    var displayName: String
    var userName: String
    var followerCount: Int
}

struct ModelBootcamp: View {
    //    @State var users: [String] = [
    //    "Nick", "Emily", "Samantha", "Chris"
    //    ]
    
    @State var users: [UserModel] = [
        UserModel(displayName: "Nick", userName: "nick123", followerCount: 100),
        UserModel(displayName: "Emily", userName: "emily123", followerCount: 33),
        UserModel(displayName: "Samantha", userName: "samantha123", followerCount: 100),
        UserModel(displayName: "Chris", userName: "Chris123", followerCount: 100)
        //    "Nick", "Emily", "Samantha", "Chris"
    ]
    
    var body: some View {
        NavigationView {
            List {
                //                ForEach(users,id: \.self) { name in
                //                    HStack(spacing: 15.0, content: {
                //                        Circle()
                //                            .frame(width: 35,height: 35)
                //                        Text(name)
                //                    })
                //                    .padding(.vertical,10)
                //                }
                
                ForEach(users) { user in
                    HStack(spacing: 15.0, content: {
                        Circle()
                            .frame(width: 35,height: 35)
                        VStack(alignment: .leading) {
                            Text(user.displayName)
                                .font(.headline)
                            Text(user.userName)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        VStack() {
                            Text("\(user.followerCount)")
                                .font(.headline)
                            Text("Followers")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                    })
                    .padding(.vertical,10)
                }
                
            }
            .listStyle(.grouped)
            .navigationTitle("Users")
        }
    }
}

#Preview {
    ModelBootcamp()
}

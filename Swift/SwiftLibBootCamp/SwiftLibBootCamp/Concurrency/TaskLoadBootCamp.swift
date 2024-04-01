//
//  TaskLoadBootCamp.swift
//  SwiftLibBootCamp
//
//  Created by 高广校 on 2024/3/13.
//

import SwiftUI

struct TaskLoadBootCamp: View {
    
    @State var image: UIImage?
    
    @StateObject var viewModel = TaskLoadViewModel()
    
    var body: some View {
        
        VStack(spacing: 30, content: {
    
            Button {
                Task {
                    do {
                        image = try await viewModel.fetchImage()
                    } catch {
                        print("Image loading failed: \(error)")
                    }
                }
            } label: {
                Text("加载图片")
            }
            
            Button {
                viewModel.removeImage()
            } label: {
                Text("移除图片")
            }
            
            Button {
                viewModel.cancelImage()
            } label: {
                Text("取消图片")
            }
            
            Button {
                click()
            } label: {
                Text("是否阻塞")
            }
            
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 200,height: 200)
            } else {
                Text("Loading...")
            }
        })
        
    }
    
    func click()  {
        print("阻塞判断")
    }
}

#Preview {
    TaskLoadBootCamp()
}

//
//  TaskLoadViewModel.swift
//  SwiftLibBootCamp
//
//  Created by 高广校 on 2024/3/13.
//

import Foundation
import Combine
import UIKit

class TaskImageModel: ObservableObject {
    @Published var image: UIImage?
}

class TaskLoadViewModel: ObservableObject {
 
//    let imageModel = TaskImageModel()
        
    var imageLoadTask: Task<UIImage?, Error>?
    
    func fetchImage() async throws -> UIImage? {
        imageLoadTask = Task { () -> UIImage? in
            let imageURL = URL(string: "https://source.unsplash.com/random")!
            print("Starting network request...")
            let (imageData, _) = try await URLSession.shared.data(from: imageURL)
            print("End network request...")
            return UIImage(data: imageData)
        }
        

        return try await imageLoadTask?.value
    }
    
    func removeImage() {
//        self.image = nil
    }
    
    func cancelImage() {
        print("cancel network request...")
        imageLoadTask?.cancel()
    }
}

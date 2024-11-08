//
//  ImageDownloader.swift
//  Swift的Actor
//
//  Created by 高广校 on 2024/11/7.
//

import Foundation
import SwiftUICore

actor ImageDownloader {
    private var cache: [URL: Image] = [:]
    
    func image(from url: URL) async throws -> Image? {
        if let cached = cache[url] {
            return cached
        }
        
        let image = try await downloadIamge(from: url)
        
        //两个以上的并行任务，缓存不存在时，一起下载时，当第一个下载完毕填充，第二个下载会覆盖
        cache[url] = image
        
        //保留原始版本 丢弃新版本
//        cache[url] = cache[url ,default: image]        
        return cache[url]
    }
    
    
    func downloadIamge(from: URL) async throws -> Image{
        return Image.init(uiImage: .add)
    }
}


actor ImageDownloader2 {
    
    private enum CacheEntry {
    
        case inProgress(Task<Image,Error>)
        case ready(Image)
    }
    
    private var cache: [URL: CacheEntry] = [:]
    
    func image(from url: URL) async throws -> Image? {
        if let cached = cache[url] {
            switch cached {
            case .inProgress(let task):
                return try await task.value
            case .ready(let image):
                return image
            }
        }
        
        //最好的解决方案是，第二个不下载：保留任务，将任务存储
        let task = Task {
             try await downloadIamge(from: url)
        }
        cache[url] = .inProgress(task)
        
        do {
            let image = try await task.value
            cache[url] = .ready(image)
            return image
        } catch {
            cache[url] = nil
            throw error
        }
    }
    
    
    func downloadIamge(from: URL) async throws -> Image{
        return Image.init(uiImage: .add)
    }
}

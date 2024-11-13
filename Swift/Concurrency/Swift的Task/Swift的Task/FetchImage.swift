//
//  FetchImage.swift
//  Swift的Task
//
//  Created by 高广校 on 2024/11/7.
//

import Foundation
import UIKit

struct FetchImage {
    
    struct ThumbnailFailedError: Error {
        
    }
    
    // 并行性量不会改变 Async-let的作用域 类似于变量绑定 这意味着两个子任务必须在 下一次循环迭代开始之前完成
    func fetchThumbnails(for ids: [String]) async throws -> [String: UIImage] {
        var thumbnails: [String: UIImage] = [:]
        for id in ids {
           thumbnails[id] = try await fetchOneThumbnail(withID: id)
        }
        return thumbnails
    }
    
    //可同时让fetchOneThumbnail一起执行，任务组
    func fetchThumbnailsV2(for ids: [String]) async throws -> [String: UIImage] {
        
        var thumbnails: [String: UIImage] = [:]
        
        try await withThrowingTaskGroup(of: Void.self) { group in
            for id in ids {
                group.async {
                    //出现多任务修改id数据竞争问题，请看V3
                    thumbnails[id] = try await fetchOneThumbnail(withID: id)
                }
            }
        }
        return thumbnails
    }
    
    func fetchThumbnailsV3(for ids: [String]) async throws -> [String: UIImage] {
        
        var thumbnails: [String: UIImage] = [:]
        
        //指定子任务包含字符串ID和缩略图的元祖
        try await withThrowingTaskGroup(of: (String,UIImage).self) { group in
            for id in ids {
                group.async {
                    return (id,try await fetchOneThumbnail(withID: id))
                }
            }
            //付任务使用新的for-awat循环从子任务遍历结果
            for try await(id,thumbnail) in group {
                thumbnails[id] = thumbnail
            }
        }
        return thumbnails
    }
    
    func fetchOneThumbnail(withID id: String) async throws -> UIImage {
        let imageReq = imageRequest(for: id), metadataReq = metadataRequest(for: id)
        async let (data, _) = URLSession.shared.data(for: imageReq)
        async let (metadata, _) = URLSession.shared.data(for: metadataReq)
        guard let size = parseSize(from: try await metadata),
              let image = try await UIImage(data: data)?.byPreparingThumbnail(ofSize: size)
        else {
            throw ThumbnailFailedError()
        }
        return image
    }
    
    func imageRequest(for url: String) -> URLRequest{
        return URLRequest(url: URL(string: url)!)
    }
    
    func metadataRequest(for url: String) -> URLRequest {
        return URLRequest(url: URL(string: url)!)
    }
    
    func parseSize(from: Data) -> CGSize? {
        return .zero
    }
    
}

////
////  The Behind Scenes.swift
////  URLSession的Async
////
////  Created by 高广校 on 2024/11/11.
////
//
//import Foundation
//
//struct Article {
//    
//}
//
//struct Feed {
//    
//}
//
//class BehindScenes: NSObject {
//    func deserializeArticles(from data: Data) throws -> [Article] { /* ... */ }
//
//    func updateDatabase(with articles: [Article], for feed: Feed) { /* ... */ }
//
//    let concurrentQueue = DispatchQueue.init(label: "qq.",attributes: .concurrent)
//    
//    func upda() {
//    
////        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: concurrentQueue)
////
////        for feed in feedsToUpdate {
////            let dataTask = urlSession.dataTask(with: feed.url) { data, response, error in
////                // ...
////                guard let data = data else { return }
////                do { 
////                    let articles = try deserializeArticles(from: data)
////                    databaseQueue.sync {
////                        updateDatabase(with: articles, for: feed)
////                    }
////                } catch { /* ... */ }
////            }
////            dataTask.resume()
////        }
//    }
//    
//}
//
//extension BehindScenes: URLSessionDelegate {
//    
//}

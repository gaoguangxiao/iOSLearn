//
//  ViewController.swift
//  Swift的Predicate
//
//  Created by 高广校 on 2024/6/24.
//

import UIKit

struct Article {
    let title: String
    let author: String
}

extension Array where Element == Article {
    
    func filter(byAuthor author:String) -> [Article]? {
        if #available(iOS 17, *) {
            let atticlesPredicate = #Predicate<Article> { $0.author == author }
            return try? self.filter(atticlesPredicate)
        } else {
            // Fallback on earlier versions
            return self.filter({$0.author == author})
        }
    }
    
//    func filter(byAuthor author:String) -> [Article]? {
//        if #available(iOS 17, *) {
//            let atticlesPredicate = #Predicate<Article> { $0.author == author }
//            return try? self.filter(atticlesPredicate)
//        } else {
//            // Fallback on earlier versions
//            return self.filter({$0.author == author})
//        }
//    }
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let articles = [
            Article(title: "Swift Macros", author: "Antoine van der Lee"),
            Article(title: "What's new in Swift 5.9", author: "Paul Hudson"),
            Article(title: "Xcode 15: Automated accessibility audits", author: "Pol Piela")
        ]
        
        if let queryArticles = articles.filter(byAuthor: "Antoine van der Lee") {
            print("queryArticles: \(queryArticles)")
        }

//        if let queryArticles = queryAuthor(byAuthor: "Antoine van der Lee1", array: articles), queryArticles.count > 0{
//            print("queryArticles: \(queryArticles)")
//        } else {
//            print("无数据")
//        }
    }
    
    //查询某作者
    func queryAuthor(byAuthor author:String, array: [Article]) -> [Article]? {
        if #available(iOS 17, *) {
            let atticlesPredicate = #Predicate<Article> { $0.author == author }
            return try? array.filter(atticlesPredicate)
        } else {
            // Fallback on earlier versions
            return array.filter({$0.author == author})
        }
    }
}

//使用try? 解包，有值返回值，无数据返回nil
//        swiftLeeArticles: [Swift的Predicate.Article(title: "Swift Macros", author: "Antoine van der Lee")]
//        swiftLeeArticlesPredicate: [Swift的Predicate.Article(title: "Swift Macros", author: "Antoine van der Lee")]

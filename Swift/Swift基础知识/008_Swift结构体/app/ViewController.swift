//
//  ViewController.swift
//  app
//
//  Created by 高广校 on 2023/11/9.
//

import UIKit

//定义一个遵循`Codable`协议名字叫`GCPerson`的结构体
struct GCPerson : Codable {
    var name : String
    var age : Int
    var height : Float //cm
    var isGoodGrades : Bool
    
}

@dynamicCallable
struct Math {
    func dynamicallyCall(withArguments args: [Int]) -> Int {
        print(args)
        // 实现调用逻辑
        return 10
    }
    
    func dynamicallyCall(withKeywordArguments args: KeyValuePairs<String, Int>) -> String {
        return args.map { label,count in
            repeatElement(label, count: count).joined(separator: " ")
        }.joined(separator: "\n")
    }
}

@dynamicMemberLookup
struct GDPerson : Codable {
    
    subscript(dynamicMember member: String) -> String {
        let properties = ["name":"Zhangsan",
                          "age": "20",
                          "sex": "男"]
        return properties[member, default: "unknown property"]
    }
}


struct GEPerson  {
    let name : String
    let age : Int
    
    let nameKeyPath : KeyPath<GEPerson,String> = \GEPerson.name
}

@dynamicMemberLookup
struct GFPerson  {
    var info : [String:Any]
    subscript(dynamicMember infoKey: String) -> Any? {
        get {
            return info[infoKey]
        }
        set {
            info[infoKey] = newValue
        }
    }
}

@dynamicMemberLookup
struct GGPerson {
    struct Info {
        var name: String
    }
    var info: Info
    
    subscript<Value>(dynamicMember keyPath: WritableKeyPath<Info, Value>) -> Value {
        get {
            return info[keyPath: keyPath]
        }
        set {
            info[keyPath: keyPath] = newValue
        }
    }
}

@dynamicMemberLookup
class ViewController: UIViewController {
    
    subscript<T>(dynamicMember keyPath: WritableKeyPath<UITextView,T>) -> T {
        get { textView[keyPath: keyPath] }
        set { textView[keyPath: keyPath] = newValue }
    }
    
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        encodePerson()
        //        decodePerson()
        
        //        let person = GCPerson(name: "XiaoMing", age: 16, height: 160.5, isGoodGrades: true)
        //        person.prinPersonInfo()
        
        let gdP = GDPerson()
        print(gdP.height)
        //        let m = Math()
        //        let result1 = m(1,2,4)
        //        let result2 = m(a: 1, b: 2,c:3)
        //        print(result2)
        
        self.textColor = UIColor.red
        
//        let keyPath = \GEPerson.name
        //keyPath的特殊语法，\GEPerson.name，它的类型是KeyPath<GEPerson,String>
        //        let p = GEPerson(name: "Lean", age: 32)
        //        let p1 = GEPerson(name: "subkey", age: 32)
        //        print(p[keyPath: keyPath])
        //        print(p[keyPath: p.nameKeyPath])
        //        print(p.name)
        //        let array = [p,p1]
        //        let names = array.map { $0.name }
        //        print(names)
        
//        var persion = GFPerson(info: [:])
//        persion.name = "Emilia"
//        print(persion.name)
        
        var persion = GGPerson(info: GGPerson.Info(name: "ggx"))
        persion.name = "jac"
        print(persion.name)
        //        p.name.map { $0.na        }
        //        print(p.name.map({ <#Self.Element#> in
        //            <#code#>
        //        }))
        //        textView.textColor =
        
    }
    
    func encodePerson()  {
        let person = GCPerson(name: "XiaoMing", age: 16, height: 160.5, isGoodGrades: true)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted // 优雅永不过时，json会好看点哟
        //        encoder.outputFormatting = .sortedKeys //生成按字典顺序排序的字典键的JSON。
        //        encoder.outputFormatting = .withoutEscapingSlashes
        do {
            //JSONEncoder编码的对象，需要遵循codable协议
            let data = try encoder.encode(person)
            let jsonStr = String(data: data, encoding: .utf8)
            textView.text = jsonStr
            print(jsonStr as Any)
        } catch let err {
            print("err", err)
        }
    }
    
    func decodePerson() {
        let jsonStr = "{\n  \"age\" : 16,\n  \"height\" : 160.5,\n  \"name\" : \"XiaoMing\",\n  \"isGoodGrades\" : true\n}"
        guard let data = jsonStr.data(using: .utf8) else {
            print("get data fail")
            return
        }
        let decoder = JSONDecoder()
        do {
            let person = try decoder.decode(GCPerson.self, from: data)
            print(person)
        } catch let err {
            print("err", err)
        }
    }
    
    
    
    
    
}


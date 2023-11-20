//
//  ViewController.swift
//  001-Swift类型
//
//  Created by gaoguangxiao on 2023/2/17.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //1、类型
        //        typealias dog = Int
        //        var a:dog = 12
        //        var b:Int = 18
        //        print(a,b)
        
        //2、() ?? 类型转换 可选类型
        
        //3、有些类型不能设置为nil
    
         var c:Int = 18
//         c = nil
//         无法编译通过
        
//        int1
        /*
         var d:Int
         print(d)
         */
        
        /*
         var e :Int?
         print(e)
         可编译通过
         */
        
        
        //4、元组数据 可拆分
        //        不同类型数据的封装
        //        var c = ("str",12)
        //        print(c)
        
        //5、穿透 fallthrough 略过进入下一步
//        let f = 10
//        switch f {
//        case 10:
//            print("1")
//            fallthrough
//        case 20:
//            print("2")
//        case 30:
//            print("3")
//        default:
//            print(0)
//        }
        
        //6、范围运算符
//        0...10 0到10
//        0..<10 0到9
//        var g = 0...10
//        var g = 0..<10
//        for index in g {
//            print(index)
//        }
        
        //不包括
//        for index in stride(from: 0, to: 10, by: 2) {
//            print(index)
//        }
//        //包括 through
//        for index in stride(from: 0, through: 10, by: 2) {
//            print(index)
//        }
        
        //7、while
//        var h = 0
//        while h < 10 {
//            h+=1
//            print(h)
//        }
//        var g = 0
//        repeat {
//            g+=1
//            print(g)
//        }while g<10
        
        //7、字符串
        /*
         var str = "123131"
 //        str.index(<#T##i: String.Index##String.Index#>, offsetBy: <#T##Int#>)
 //        str.index(after: <#T##String.Index#>)
         print(str)
         
 //        两字符串比较是否包含同一元素
         var str1 = "1343535"
         print(str.contains("1"))
         
         print(str.contains(where: String.contains("145678")))
 //        追加
         str.append("1313131422")
         print(str)
         */
        
        /*
         var dic = ["12":"value"]
 //        dic.keys
 //        dic
 //        dic.values
         dic.updateValue("ad", forKey: "12")
         print(dic)
         */
        
        /*//        let a = 10
         //        assert(a != 10,"a必须等于10")
         //        print("a = \(a)")
         */
        
//        let a : ()->Void = test
//        a()
//        //无参数 无返回值
//        let a1 : ()->Void = {()->Void in
//            print("匿名函数")
//        }
//        a1()

        
        //有参无返回值
//        let b:(String) ->Void = tests(s:)
//        b("好")
//
//        let b1 :(String) -> Void = { (s:String) -> Void in
//            print("有参无返回值\(s)")
//        }
//        b1("好1")
        
//        无参有返回值
//        let c :() -> String = {() -> String in
//            return "好好"
//        }
//
////        有参有返回值
//        let d:(String) -> String = { (a:String) -> String in
//
//            return a + "adad"
//        }
                
//        print(c())
//        print(d("4567y8uijokhy7"))
        
        
//        funMe(para: test)
        
        sun(para: (a: Int, b: Int))
    }
    
    func test() {
        print("test1")
    }
    
    func tests(s:String) -> Void {
        print(s)
    }
    
    func funMe(para:() -> Void) {
        para()
    }
    
    func sun(para:(Int,Int) -> Int) -> Int {
    para(Int,Int)
    }
    
    
}


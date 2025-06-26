//
//  SQLiteManager.swift
//  Demo_SQLite.Swift
//
//  Created by 高广校 on 2024/11/1.
//

import Foundation
import SQLite
import GGXSwiftExtension

//Expression：表示表中列以及数据类型，ExpressionType是一个协议，所有的Expression遵循此协议

//指定SQLite.Expression，避免系统库冲突
typealias SQLiteExpression = SQLite.Expression

struct UserTable {
    
    // Int64 -> Integer
    // Id
    static let userId   = SQLiteExpression<Int64>("userId")
    
    // string -> Text
    // 用户名
    static let userName = SQLiteExpression<String>("username")
    // 密码
    static let password = SQLiteExpression<String>("password")

    // 积分
    static let score = SQLiteExpression<Double>("score") //
    // 手机号
    static let userPhone = SQLiteExpression<String>("phone")
    
}

public class SQLiteManager: NSObject {
    
    private var db: Connection?
    
    private let users = Table("users") //表名
    
    override init() {
        super.init()
        try? createdsqlite3()
        
        //插入数据
        inserData(username: "小明", userphone: "110", pswd: "000")
    }
    
    //创建数据库链接
    public func createdsqlite3(filePath : String = "/ds") throws {
             
        guard let documentPath = FileManager.documentPath else {
            return
        }
        let sqlFilePathFolder = documentPath + filePath
        
        //创建filepath文件夹路径，内部会进行判断
        FileManager.createFolder(atPath: sqlFilePathFolder)
       
        //文件路径
        let sqlFilePath = sqlFilePathFolder + "/db.sqlite3"

        do {
            db = try Connection(sqlFilePath)
            print("create connection success：\(sqlFilePath)")
        } catch {
            print("create connection error：\(error)")
            throw error
        }
        
        try createTable()
    }
    
    //创建表
    public func createTable() throws {
        guard let db else {
            print("please init connection db")
            return
        }
        
        let queryUser = users.create(ifNotExists: true) { t in
            t.column(UserTable.userId, primaryKey: true)
            t.column(UserTable.userName)
            t.column(UserTable.score)
            t.column(UserTable.password)
            t.column(UserTable.userPhone)
        }
                
        do {
            try db.run(queryUser)
            print("createTable user success")
        } catch  {
            print("createTable user faile")
            throw error
        }
    }
    
    //用户表插入数据
    func inserData(username:String,userphone:String,pswd:String) {
        guard let db else {
            print("please init connection db")
            return
        }
        do {
            let insert = users.insert(or: .replace, [
                UserTable.userName <- username,
                                          UserTable.score <- 0,
                                          UserTable.password <- pswd,
                                          UserTable.userPhone <- userphone
            ])
            try db.run(insert)
            print("inserData user success")
        } catch {
            print(error)
        }
    }
    
    //读取数据
    public func queryData() {
        let userData = (readUserName: "test",
                        readPswd: "000000",
                        readScore: 0)
        var userDataArr = [userData]
        
        if let udata = try? db?.prepare(users) {
            for user in udata {
                var userData = (readUserName:"test",
                                readPswd:"000000",
                                readScore: 0)
                userData.readUserName = user[UserTable.userName]
                userData.readPswd     = user[UserTable.password]
                userData.readScore = Int(user[UserTable.score])
                print("queryData user success：\(user[UserTable.userId])")
                //向数组中加入元素
                userDataArr.append(userData)
            }
        } else {
            print("queryData user fail")
        }
    }
    
    
    //更新
    func updateUser(id: Int64 = 1, phone: String) {
        guard let db else {
            print("please init connection db")
            return
        }
        do {
            //条件
            let update = users.filter(UserTable.userId == id)
            //语句
            let query = update.update(
                UserTable.userPhone <- phone
            )
            //运行
            try db.run(query)
            print("update user success")
        } catch {
            print("update user fail: \(error)")
        }
    }
    
    func deleteUser(id: Int64 = 1) {
        guard let db else {
            print("please init connection db")
            return
        }
        do {
            //条件
            let delete = users.filter(UserTable.userId == id)
//            //语句
            let query = delete.delete()
            //运行
            try db.run(query)
            print("delete user success")
        } catch {
            print("delete user fail: \(error)")
        }
    }
    
    //查指定用户
    public func queryUser(_ Id: Int64 = 1) {
        guard let db else {
            print("please init connection db")
            return
        }
        let alice = users.filter(UserTable.userId == Id)
        guard let datas: AnySequence<Row> = try? db.prepare(alice) else {
            print("Query preparation failed")
            return
        }
        
        for user in datas {
            print("queryData user success：\(user[UserTable.userPhone])")
        }
    }
}

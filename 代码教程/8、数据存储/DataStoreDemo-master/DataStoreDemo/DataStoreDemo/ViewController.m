//
//  ViewController.m
//  DataStoreDemo
//
//  Created by gaoguangxiao on 2018/3/28.
//  Copyright © 2018年 gaoguangxiao. All rights reserved.
//

#import "ViewController.h"

#import <sqlite3.h>
@interface ViewController ()
{
    sqlite3 *_sqlite3;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self sandBoxIntroduce];
    
//    1、plist文件存储
//    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
//    NSString *fileName = [path stringByAppendingPathComponent:@"123.plist"];
//    NSArray *array = @[@"123", @"456", @"7810"];
//    [array writeToFile:fileName atomically:YES];
//    NSLog(@"%@ ----",fileName);
//    NSArray *result = [NSArray arrayWithContentsOfFile:fileName];
//    NSLog(@"%@", result);
    
//    2.获得NSUserDefaults文件
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    //2.向文件中写入内容
//    [userDefaults setObject:@"AAA" forKey:@"a"];
//    [userDefaults setBool:YES forKey:@"sex"];
//    [userDefaults setInteger:21 forKey:@"age"];
//    //2.1立即同步
//    [userDefaults synchronize];
//    //3.读取文件
//    NSString *name = [userDefaults objectForKey:@"a"];
//    BOOL sex = [userDefaults boolForKey:@"sex"];
//    NSInteger age = [userDefaults integerForKey:@"age"];
//    NSLog(@"%@, %d, %ld", name, sex, age);
    

//    3、数据库操作
    [self openDatabase];
    
    [self readData];
}

- (void)sandBoxIntroduce {
    //沙盒路径
    NSString *homed = NSHomeDirectory();
    NSLog(@"沙盒路径（NSHomeDirectory）%@",homed);
    
    //Document路径
    NSString *searchDocumentPathDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSLog(@"Document路径（NSSearchPathForDirectoriesInDomains）%@",searchDocumentPathDir);
    /*
     Document路径（NSSearchPathForDirectoriesInDomains）/Users/gaoguangxiao/Library/Developer/CoreSimulator/Devices/2AA54A91-C606-4693-A2D7-13036C678203/data/Containers/Data/Application/550D5CB8-8A2F-45AB-B5D1-7613769B910C/Documents
     */
    
    //
    NSString *searchLibraryPathDir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
    NSLog(@"Library路径（NSSearchPathForDirectoriesInDomains）%@",searchLibraryPathDir);
    
    //Caches
    NSString *slCachesPathDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSLog(@"Library/Caches路径（NSSearchPathForDirectoriesInDomains）%@",slCachesPathDir);
    
    //Preferesnce
    NSString *slPreferencePathDir = NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES).firstObject;
    NSLog(@"Library/Preference路径（NSSearchPathForDirectoriesInDomains）%@",slPreferencePathDir);
    
    //    NSUserDefaults;
    slPreferencePathDir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"Preference"];
    NSLog(@"Library/Preference路径（NSSearchPathForDirectoriesInDomains）%@",slPreferencePathDir);
    
//    NSTemporaryDirectory();
}

- (void)openDatabase {
    //1.设置文件名
    NSString *filename = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"person.db"];
    NSLog(@"%@",filename);
    //2.打开数据库文件，如果没有会自动创建一个文件
    NSInteger result = sqlite3_open(filename.UTF8String, &_sqlite3);
    if (result == SQLITE_OK) {
        NSLog(@"打开数据库成功！");
        //3.创建一个数据库表
        char *errmsg = NULL;
        sqlite3_exec(_sqlite3, "CREATE TABLE IF NOT EXISTS t_person(id integer primary key autoincrement, name text, age integer)", NULL, NULL, &errmsg);
        if (errmsg) {
            NSLog(@"错误：%s", errmsg);
        } else {
            NSLog(@"创表成功！");
            
//            [self insertData];
        }
    } else {
        NSLog(@"打开数据库失败！");
        
    }
    
}
- (void)insertData {
    NSString *nameStr;
    NSInteger age;
    for (NSInteger i = 0; i < 10; i++) {
        nameStr = [NSString stringWithFormat:@"Bourne-%d", arc4random_uniform(10)];
        age = arc4random_uniform(80) + 20;
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO t_person (name, age) VALUES('%@', '%ld')", nameStr, age];
        char *errmsg = NULL;
        sqlite3_exec(_sqlite3, sql.UTF8String, NULL, NULL, &errmsg);
        if (errmsg) {
            NSLog(@"错误：%s", errmsg);
        }
    }
    NSLog(@"插入完毕！");
}

/**
 *  从表中读取数据到数组中
 */
- (void)readData {
//    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:10];
    char *sql = "select name, age from t_person;";
    sqlite3_stmt *stmt;
    NSInteger result = sqlite3_prepare_v2(_sqlite3, sql, -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            char *name = (char *)sqlite3_column_text(stmt, 0);
            NSInteger age = sqlite3_column_int(stmt, 1);
            NSLog(@"%@的年龄是 = %ld",[NSString stringWithUTF8String:name],age);
            //创建对象
//            Person *person = [Person personWithName:[NSString stringWithUTF8String:name] Age:age];
//            [mArray addObject:person];
        }
//        self.dataList = mArray;
    }
    sqlite3_finalize(stmt);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  main.m
//  001_OC结构体
//
//  Created by gaoguangxiao on 2023/3/11.
//

#import <Foundation/Foundation.h>

struct Student {
    NSString *name;
    NSInteger age;
};

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        Student *stu = Student;
        stu.name = @"张三";
        
        NSLog(@"%@",stu.name);
        
    }
    return 0;
}

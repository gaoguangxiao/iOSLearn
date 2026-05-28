//
//  main.m
//  002_OC面向对象
//
//  Created by gaoguangxiao on 2023/3/12.
//

#import <Foundation/Foundation.h>


@interface Perspon : NSObject

@end

@implementation Perspon

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        Perspon *p = [[Perspon alloc]init];
       //对象isa指针 指向对象所属类在代码段的地址
        //调用属性：根据指针 找到指针指向的对象，找到对象属性来访问
        //调用方法：先根据指针名 找到对象的isa指针，根据对象isa指针找到类的方法
        
        //OC方法 需要实例化对象调用 函数直接调用
//        都是封装一段代码
    }
    return 0;
}

//
//  main.m
//  使用typedef定义
//
//  Created by gaoguangxiao on 2023/3/14.
//

#import <Foundation/Foundation.h>

//typedef使用场景
//将长类型定义短类型 重新定义

//定义 无参无返回 block
typedef void(^blockName)(void);

//无返回 有参
typedef void(^blockName1)(int);

//无参 有返回
typedef int(^blockName2)(void);

//有参 有返回
typedef int(^blockName3)(int);



int main(int argc, const char * argv[]) {
    @autoreleasepool {
       
        blockName vv = ^{
            NSLog(@"vv");
        };
        vv();
        
        
    }
    return 0;
}

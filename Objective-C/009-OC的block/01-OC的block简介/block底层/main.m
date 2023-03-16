//
//  main.m
//  block底层
//
//  Created by gaoguangxiao on 2023/3/14.
//

#import <Foundation/Foundation.h>

int b = 100;
typedef void(^blockName)(void);
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        //1、将本文件转为 cpp或者 c的形式展示
        
        //了解 block为何无法修改 局部变量的值，加了__block可以修改的原因
        
        blockName vv1 = ^{
            b++;
        };
        vv1();
        NSLog(@"%d",b);//堆
        
//        __block 指针传递
    }
    return 0;
}


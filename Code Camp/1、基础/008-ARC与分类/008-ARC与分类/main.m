//
//  main.m
//  008-ARC与分类
//
//  Created by gaoguangxiao on 2023/3/13.
//

#import <Foundation/Foundation.h>
#import "Car.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        __weak Car *car = [Car new];
        //创建之后 就销毁
        
//        car = nil;
        
    }
    return 0;
}

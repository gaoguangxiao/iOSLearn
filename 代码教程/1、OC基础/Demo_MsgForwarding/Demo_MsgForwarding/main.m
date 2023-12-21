//
//  main.m
//  Demo_MsgForwarding
//
//  Created by 高广校 on 2023/8/9.
//

#import <Foundation/Foundation.h>
#import "GGXPerson.h"
#import "NSObject+GX.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        //消息转发
//        GGXPerson *p = [[GGXPerson alloc]init];
//        [p speak];
        
        //验证子类类方法调用 nsob对象方法
        [GGXPerson instanceMethod];
    }
    return 0;
}

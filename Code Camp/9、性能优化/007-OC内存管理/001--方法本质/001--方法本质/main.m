//
//  main.m
//  001--方法本质
//
//  Created by gaoguangxiao on 2023/2/14.
//

#import <Foundation/Foundation.h>
#import "LGPerson.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        //        LGPerson *p = [[LGPerson alloc]init];
        //        [p saySomething];
        //        1、方法本质：消息发送 objc_msgSend
        
        //        2、SEL 函数名字
        //        IMP 函数地址 找到具体函数的实现
        
        //        3、消息查找
        //        汇编快速查找 cache_t -> bucket
        //        慢速查找 methoList
        
        //        4、消息转发
        //        动态消息决议 resInstace 方法添加
        //        慢速 交给其他类实现
        //        快速 invacation
        
//        NSString *name = @"ggx";
        
        //
        Class cls = [LGPerson class];
        void *g = &cls;
        [(__bridge id)g saySomething];// 对象方法（实例方法） 存在类中
        
        LGPerson *p = [[LGPerson alloc]init];
        [p saySomething];
        
    }
    return 0;
}

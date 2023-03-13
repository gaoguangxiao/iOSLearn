//
//  main.m
//  Demo_TaggedPointer
//
//  Created by gaoguangxiao on 2023/2/12.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        //        NSLog(@"Hello, World!");
        
        //1、NSString创建下面有区别吗
//        =@"";
//        [NSString stringWithFormat:@""]; //创建较长字符串
        
//        NSCFString OC对象
//        NSCFConstantString 常量区
        
        NSString *str1 = @"哈哈";
        NSString *str2 = [NSString stringWithFormat:@"哈哈"];
        NSLog(@"str1 %p = %@",&str1,str1);
        NSLog(@"str2 %p = %@",&str2,str2);
        
//        __block NSString *str = @"Hello, World!";
//        NSLog(@"str = %@",str);
        //实例1：
        /*
        dispatch_queue_t queue = dispatch_queue_create("com.djx.cn", DISPATCH_QUEUE_CONCURRENT);
        for (int i = 0; i<10000; i++) {
            dispatch_async(queue, ^{
                str = [NSString stringWithFormat:@"123456789"];
                NSLog(@"str:%p-%@",&str,str);
            });
        }
        
         */
        
        //实例2：
        /*
        dispatch_queue_t queue = dispatch_queue_create("com.djx.cn", DISPATCH_QUEUE_CONCURRENT);
        for (int i = 0; i<10000; i++) {
            dispatch_async(queue, ^{
                str = [NSString stringWithFormat:@"1234567890"];
                NSLog(@"str:%p-%@",&str,str);
            });
        }*/
        
        
    }
    return 0;
}


//
//  main.m
//  nil和NULL
//
//  Created by gaoguangxiao on 2023/3/12.
//

#import <Foundation/Foundation.h>

@interface Perspon : NSObject
{
    @public
    NSString *_score;
}

@property (nonatomic, copy) NSString *name;

- (void)say;

@end

@implementation Perspon

//- (void)say {
//    NSLog(@"说话");
//}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        /**
         NULL 可以作为指针变量的值，如果一个指针变量 是NULL的代表，那么它不指向内存任何一块内存
        
         NULL是一宏定义 0 C语言是一
         
         nil 也是 	OC对象
         */
        
        int a = NULL;
        
        if (nil == NULL) {
            
            NSLog(@"一样");
        }
        
        Perspon *p = [Perspon new];
//        [p say];//方法没有响应
//        p.name = @"张三";//不会报错
//        p->_score = @"12112";//报错
        @try {//并不是万能的
            [p say];//方法没有响应
//            p->_score = @"12112";//报错
        } @catch (NSException *exception) {
            NSLog(@"：exception%@",exception);
        }
        
        
        
        
        
        NSLog(@"Hello, World!");
    }
    return 0;
}

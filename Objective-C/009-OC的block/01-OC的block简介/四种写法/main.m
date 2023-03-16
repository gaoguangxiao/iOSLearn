//
//  main.m
//  四种写法
//
//  Created by gaoguangxiao on 2023/3/14.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
       /**
        简写：
        1、声明代码块的 参数名可以省略
        2、代码段的返回值 可以不用写 ^
        */
        
        //无参 无返回值
        void(^a)(void) = ^{
            NSLog(@"无参 无返回值");
        };
        a();
        
        //有参 无返回值
        void (^b)(int param) = ^(int tmpParam){
            NSLog(@"有参 无返回值 - 参数：%d",tmpParam);
        };
        
//        有参 无返回值简写
        void (^b1)(int) = ^(int tmp){
            NSLog(@"有参 无返回值简写：%d",tmp);
        };
        b(29);
        b1(10);
        
        //无参 有返回值
        int (^c)(void) = ^{
            NSLog(@"无参 有返回值");
            return  10;
        };
        c();
        
        //有参 有返回值
        int (^d)(int a) = ^(int tmpA){
            NSLog(@"有参 有返回值：%d",tmpA);
            return tmpA + 10;
        };
        d(20);
        
    }
    return 0;
}

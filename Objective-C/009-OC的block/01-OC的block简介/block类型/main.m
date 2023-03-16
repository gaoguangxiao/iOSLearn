//
//  main.m
//  block类型
//
//  Created by gaoguangxiao on 2023/3/14.
//

#import <Foundation/Foundation.h>

//定义 无参无返回 block
typedef void(^blockName)(void);

int a = 100;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
       
        //可以修改a的值，block内部可以修改全局变量
        blockName vv = ^{
//            a += 10;
//            NSLog(@"a = %d",a);
        };
        NSLog(@"%@",vv); /////<: 0x100004030>
        vv();

        int b = 100;
        blockName vv1 = ^{
            NSLog(@"b = %d",b);
        };
        NSLog(@"%@",vv1);//堆
        vv1();
        
    }
    return 0;
}

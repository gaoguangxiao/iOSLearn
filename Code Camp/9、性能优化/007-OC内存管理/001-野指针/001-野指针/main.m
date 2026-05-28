//
//  main.m
//  001-野指针
//
//  Created by gaoguangxiao on 2023/2/15.
//

#import <Foundation/Foundation.h>
#import "LGPerson.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        //1、野指针
        /**
         C：指针指向任意的一块内存空间
         OC:指针指向系统回收/释放的对象，指针没有作任何修改，仍然指向回收的内存空间
         */
        
        //2、空指针
        
        //3、僵尸对象
        //系统要回收的对象，引用计数器器为0
        
        //4、内存回收的本质
        //向系统申请一块内存，一块别人不使用的
        //释放一块内存，这块内存 可供系统分配给别的对象
        
        //3、开启僵尸对象检测
        
        LGPerson *p = [[LGPerson alloc]init];
        NSLog(@"before:%@",p);
        [p release];
//        NSLog(@"after:%@",p);
        
    }
    return 0;
}

void test() {

    char *str1 = "123";
    char *str2;
    strcpy(str2, str1);
    printf("str2的值：%u\n",str2);
}


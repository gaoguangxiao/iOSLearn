//
//  main.m
//  005-OC继承
//
//  Created by gaoguangxiao on 2023/3/12.
//

#import <Foundation/Foundation.h>
#import "sun.h"

void test(int a) {
    
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
//        NSLog(@"Hello, World!");
        
        sun *s = [sun new];
        
        Class cl = [sun class];
        
    
        //const案例
        int a = 1;
        int *p = &a;// 带*的变量为指针变量
        
        NSLog(@"a = %d", a);
        NSLog(@"&a = %p", &a); //&a = 0x16fdff24c
        NSLog(@"p = %p", p);   //p = 0x16fdff24c
        NSLog(@"*p = %d", *p); //*p = 1
        //&a，获取a的指针变量，p表示a的指针变量的值，*p：a的值
        
//        //案例2，修改*p的值
        int c = 2;
//        p = &c;
//        NSLog(@"p = %p", p);   //p = 0x16fdff23c
//        NSLog(@"*p = %d", *p); //*p = 2
//        
//        //案例3，通过指针变量 修改内存存储的值
//        *p = 20;
//        NSLog(@"*p = %d", *p); //*p = 20
        
        
        //const修饰指针变量访问的内存空间，表示此空间的数据不可被修改
        const int *p1;
        int const *p2;
        
        //const修饰指针变量p3，表示指针变量不可被修改
        int * const p3;
        
        p1 = &c;
        NSLog(@"p1 = %p", p1); //*p = 20
        
//        案例4；提供一个方法，方法的参数是地址，里面可以通过地址读取值
//        test(<#int a#>)
    }
    
   
    return 0;
}

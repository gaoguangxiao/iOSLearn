//
//  main.m
//  Demo_Class
//
//  Created by 高广校 on 2023/8/6.
//

#import <Foundation/Foundation.h>
#import "CJPerson.h"
#import <objc/runtime.h>
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        //类结构体中objc_class的cache_t
        
//        struct cache_t {
//            struct bucket_t *buckets() const;
//            mask_t mask() const;
//            mask_t _occupied;
//        }
        //探究cach_t的作用，缓存策略，方法调用
        
        CJPerson *person = [[CJPerson new]init];
        Class cls1 = object_getClass(person);
        [person firstAction];
        
        Class cls2 = object_getClass(person);
        [person secondAction];
        
        Class cls3 = object_getClass(person);
        [person thirdAction];
        
        Class cls4 = object_getClass(person);
        [person fourthAction];
        
    }
    return 0;
}

//
//  main.m
//  Demo_Block
//
//  Created by 高广校 on 2023/8/1.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int age = 10;
        void (^block)(void) = ^{
            NSLog(@"age is %d",age);
        };
        //
        block();
    }
    return 0;
}

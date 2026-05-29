//
//  main.m
//  004-OC位域
//
//  Created by 高广校 on 2025/3/18.
//

#import <Foundation/Foundation.h>
#import "ZSXPerson.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        ZSXPerson *person = [[ZSXPerson alloc] init];
        person.tall = NO;
        person.rich = YES;
        person.handsome = YES;
        
        NSLog(@"tall:%d  rich:%d  handsome:%d", person.isTall, person.isRich, person.isHandsome);
    }
    return 0;
}

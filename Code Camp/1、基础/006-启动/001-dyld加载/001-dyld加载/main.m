//
//  main.m
//  001-dyld加载
//
//  Created by 高广校 on 2025/3/21.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

__attribute__((constructor))void SAFuc() {
    printf("走了SAFuc：%s \n",__func__);
}

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        NSLog(@"Hello world");
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}

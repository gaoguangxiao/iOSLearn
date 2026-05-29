//
//  main.m
//  001-alloc&init探索
//
//  Created by gaoguangxiao on 2023/2/13.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
/**
 1、bt (backtace)打印当前调用堆栈
 2、设置符号断点
 3、举例一些符号表：libSystem_initializer、libdispatch_init 、_objc_init
 */

/**
 1、苹果开源代码地址：opensource.apple.com 下载objc_4
 */
int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}

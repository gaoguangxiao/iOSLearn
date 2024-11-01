//
//  UIDevice+Height.m
//  Hanpusen
//
//  Created by gaoguangxiao on 2022/5/30.
//  Copyright © 2022 高广校. All rights reserved.
//

#import "UIDevice+Height.h"

@implementation UIDevice (Height)

- (BOOL)isPad {
    static dispatch_once_t one;
    static BOOL pad;
    dispatch_once(&one, ^{
        pad = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
    });
    return pad;
}

//状态栏高度(来电等情况下，状态栏高度会发生变化，所以应该实时计算)
- (CGFloat)HPStatusBarHeight {
    UIWindow *window = UIApplication.sharedApplication.windows.firstObject;
    if (self.isPad) {
        if (@available(iOS 11.0, *)) {
            if (window.safeAreaInsets.bottom > 0 ){
                return 24;
            } else {
                return 20;
            }
        } else {
            // Fallback on earlier versions
            return 20;
        }
    } else {
        if (@available(iOS 11.0, *)) {
            if (window.safeAreaInsets.bottom > 0 ){
                return window.safeAreaInsets.top;
            } else {
                return 20;
            }
        } else {
            // Fallback on earlier versions
            return 20;
        }
    }
}

- (CGFloat)HPNavigationBarHeight {
    if (self.isPad) {
        UIEdgeInsets safeAreaInset = UIApplication.sharedApplication.delegate.window.safeAreaInsets;
        if (UIEdgeInsetsEqualToEdgeInsets(safeAreaInset, UIEdgeInsetsZero)) {
            return 44;
        } else {
            return 50;
        }
    } else {
        return 44;
    }
    return 44;
}

- (CGFloat)HPTopBarHeight {
    return self.HPStatusBarHeight + self.HPNavigationBarHeight;
}
@end

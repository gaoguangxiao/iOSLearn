//
//  SceneDelegate.m
//  Demo_NSUserDefaults
//
//  Created by gaoguangxiao on 2024/6/13.
//  Copyright © 2024 gaoguangxiao. All rights reserved.
//

#import "SceneDelegate.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // 使用 Main.storyboard 创建窗口
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *rootVC = [storyboard instantiateInitialViewController];
    
    self.window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
}

- (void)sceneDidDisconnect:(UIScene *)scene {
    // 当场景与应用程序断开连接时调用
}

- (void)sceneDidBecomeActive:(UIScene *)scene {
    // 当场景从非活动状态变为活动状态时调用
}

- (void)sceneWillResignActive:(UIScene *)scene {
    // 当场景从活动状态变为非活动状态时调用
}

- (void)sceneWillEnterForeground:(UIScene *)scene {
    // 当场景从后台进入前台时调用
}

- (void)sceneDidEnterBackground:(UIScene *)scene {
    // 当场景从前台进入后台时调用
}

@end

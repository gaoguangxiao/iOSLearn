//
//  AppDelegate.m
//  Demo_NSUserDefaults
//
//  Created by gaoguangxiao on 2024/6/13.
//  Copyright © 2024 gaoguangxiao. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}

#pragma mark - UISceneSession Lifecycle

- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}

- (void)application:(UISceneSession *)sceneSession didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    
}

@end

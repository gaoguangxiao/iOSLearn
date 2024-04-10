//
//  CGOpetaion.m
//  008_OpQueue
//
//  Created by 高广校 on 2023/8/15.
//

#import "CGOpetaion.h"

@implementation CGOpetaion

-(void)main {
    if (!self.isCancelled) {
        for (int i = 0; i < 4; i++) {
            sleep(2);
            NSLog(@"%d==%@", i, NSThread.currentThread);
        }
    }
}

@end

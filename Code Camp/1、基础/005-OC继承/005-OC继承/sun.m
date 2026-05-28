//
//  sun.m
//  005-OC继承
//
//  Created by gaoguangxiao on 2023/3/12.
//

#import "sun.h"

@implementation sun

- (id)init
{
    self = [super init];
    if (self)
    {
        NSLog(@"%@", NSStringFromClass([self class]));
        NSLog(@"%@", NSStringFromClass([super class]));
    }
    return self;
}

@end

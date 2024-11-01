//
//  MTMan.m
//  Demo_MapTable
//
//  Created by 高广校 on 2023/8/14.
//

#import "MTMan.h"

@implementation MTMan

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    MTMan *mt = [[[self class]allocWithZone:zone]init];
    return mt;
}

@end

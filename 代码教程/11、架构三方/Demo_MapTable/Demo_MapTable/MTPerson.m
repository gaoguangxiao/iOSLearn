//
//  MTPerson.m
//  Demo_MapTable
//
//  Created by 高广校 on 2023/8/14.
//

#import "MTPerson.h"

@implementation MTPerson


- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    MTPerson *mt = [[[self class]allocWithZone:zone]init];
    return mt;
}

@end

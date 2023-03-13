//
//  Person.m
//  007_intanceTypeID
//
//  Created by gaoguangxiao on 2023/3/11.
//

#import "Person.h"

@implementation Person

- (instancetype)init {
    self = [super init];
    if (self) {}
    return self;
}

//- (id)init {
//    self = [super init];
//    if (self) {}
//    return self;
//}

- (instancetype)setPersonValue:(id)value forKey:(NSString *)key {
    
    return self;
}

/**
 都可以作为init返回值
 1、instancetype编译期确定对象类型，id运行时确定
 2、id可以作为方法的参数，二instanceType不可以
 */


@end

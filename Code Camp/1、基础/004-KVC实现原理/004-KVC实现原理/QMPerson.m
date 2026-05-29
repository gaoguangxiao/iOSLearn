//
//  QMPerson.m
//  004-KVC实现原理
//
//  Created by gaoguangxiao on 2023/2/18.
//

#import "QMPerson.h"

@implementation QMPerson

+ (BOOL)accessInstanceVariablesDirectly {
    return YES;
}

//让KVC支持可变数组操作
- (NSMutableArray *)mutableArrayValueForKey:(NSString *)key {
    if ([key isEqualToString:@"friends"]) {
            return [self mutableArrayValueForKey:@"friends"];
        }
        return [super mutableArrayValueForKey:key];
}
@end

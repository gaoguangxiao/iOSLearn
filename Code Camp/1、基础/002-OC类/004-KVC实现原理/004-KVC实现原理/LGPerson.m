//
//  LGPerson.m
//  004-KVC实现原理
//
//  Created by gaoguangxiao on 2023/2/17.
//

#import "LGPerson.h"

@implementation LGPerson

//- (void)setName:(NSString *)name {
//    NSLog(@"setName");
//}
//
//- (void)_setName:(NSString *)name {
//    NSLog(@"_setName");
//}

//这二步执行的前提是 setName/_setName没有找到
//+ (BOOL)accessInstanceVariablesDirectly {
//    return NO;
//}

//第三步判断成员变量前提是 accessInstanceVariablesDirectly设置为YES
//_name/_isName/name/isName

//第四步 成员变量找不到 执行此方法
//- (void)setValue:(id)value forUndefinedKey:(NSString *)key
//- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
//
//}


//如果accessInstanceVariables返回NO，就不查找成员变量，直接执行第四步；
//只要重写第四步方法 就不会抛出异常了？

@end

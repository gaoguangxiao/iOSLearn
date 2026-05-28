//
//  LGPerson.m
//  001--方法本质
//
//  Created by gaoguangxiao on 2023/2/14.
//

#import "LGPerson.h"

@implementation LGPerson

- (void)saySomething {
    NSLog(@"%s--%@",__func__,self.name);
}

//动态方法决议
//+ (BOOL)resolveClassMethod:(SEL)sel

//+ (BOOL)resolveInstanceMethod:(SEL)sel

//快速 form
//- (id)forwardingTargetForSelector:(SEL)aSelector


//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
//- (void)forwardInvocation:(NSInvocation *)anInvocation

//invacation
@end

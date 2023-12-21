//
//  GGXPerson.m
//  Demo_MsgForwarding
//
//  Created by 高广校 on 2023/8/9.
//

#import "GGXPerson.h"
#import <objc/runtime.h>
#import "GGXPerson2.h"
@implementation GGXPerson

- (void)instanceMethod{
    NSLog(@"%s--我是GGXPerson的对象方法",__func__);
}

//动态方法决议
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    //未实现的方法判断
    if (sel == @selector(speak)) {
        NSLog(@"动态方法决议");
//        Method method = class_getInstanceMethod(self, @selector(play));
//        const char *types = method_getTypeEncoding(method);
//        IMP imp = class_getMethodImplementation(self, @selector(play));
//        return class_addMethod(self, sel, imp, types);
    }
    return [super resolveInstanceMethod:sel];
}

- (void)play {
    NSLog(@"play");
}

//
- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(speak)) {
        return [GGXPerson2 alloc];
    }
    return [super forwardingTargetForSelector:aSelector];
}

//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
//   if (aSelector == @selector(speak)) {
//        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
//    }
//    return [super methodSignatureForSelector:aSelector];
//}
//
//- (void)forwardInvocation:(NSInvocation *)anInvocation{
//   SEL aSelector = [anInvocation selector];
//   if ([[GGXPerson2 alloc] respondsToSelector:aSelector])
//       [anInvocation invokeWithTarget:[GGXPerson2 alloc]];
//   else
//       [super forwardInvocation:anInvocation];
//}

@end

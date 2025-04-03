//
//  LGPerson+LG.m
//  009-关联对象
//
//  Created by 高广校 on 2025/3/27.
//

#import "LGPerson+LG.h"
#import <objc/runtime.h>

@implementation LGPerson (LG)

- (void)setCate_name:(NSString *)cate_name {
    
    objc_setAssociatedObject(self, "cate_name", cate_name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)cate_name {
    return objc_getAssociatedObject(self, "cate_name");
}
@end

//
//  A.m
//  Demo_pushVC
//
//  Created by gaoguangxiao on 2022/4/7.
//

#import "A.h"
#import "B.h"
@implementation A

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        B *b = [[B alloc]initWithFrame:self.bounds];
        
        [self addSubview:b];
    }
    return self;
}

@end

//
//  B.m
//  Demo_pushVC
//
//  Created by gaoguangxiao on 2022/4/7.
//

#import "B.h"

@implementation B

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = self.bounds;
        [btn setTitle:@"点击" forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    return self;
}

- (void)tap {
//    NSLog(@"%@",self.nextResponder);
//    
//    UIViewController *vc = self.nextResponder.nextResponder.nextResponder;
//    SEL sel = NSSelectorFromString(@"dosomething");
//    [vc performSelector:sel];
//    NSLog(@"%@",self.nextResponder.nextResponder.nextResponder);
//    
//    NSLog(@"%@点击",self.class);
}
@end

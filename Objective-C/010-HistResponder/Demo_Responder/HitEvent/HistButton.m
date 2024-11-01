//
//  HistButton.m
//  HitEvent
//
//  Created by gaoguangxiao on 2018/7/31.
//  Copyright © 2018年 gaoguangxiao. All rights reserved.
//

#import "HistButton.h"

@implementation HistButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    //先判断触摸点是否在本视图
    if ([self pointInside:point withEvent:event]) {
        
        //查找子视图
        for (UIView *s in self.subviews) {
            //将触摸点
            CGPoint pointView = [s convertPoint:point fromView:self];//将自身坐标系转换到子视图中去
            NSLog(@"响应者子视图tag：%ld,子视图颜色：%@",s.tag,s.backgroundColor);
//            UIView *p = [s hitTest:pointView withEvent:event];
            if ([s hitTest:pointView withEvent:event]) {
                return s;
            }
        }
        NSLog(@"响应者视图：%ld",self.tag);
        
        return self;
    }else{
        return nil;
    }
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
//    return self.bounds.
    return [super pointInside:point withEvent:event];
}
@end

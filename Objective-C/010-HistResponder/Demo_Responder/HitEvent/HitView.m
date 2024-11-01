//
//  HitView.m
//  HitEvent
//
//  Created by gaoguangxiao on 2018/7/31.
//  Copyright © 2018年 gaoguangxiao. All rights reserved.
//

#import "HitView.h"

@implementation HitView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//命中测试找第一响应者
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    //先判断触摸点是否在本视图
    NSLog(@"响应者视图：%ld",self.tag);
    if ([self pointInside:point withEvent:event]) {
        return self;
    }else{
        //查找
        for (UIView *s in self.subviews) {
            //将触摸点
            CGPoint pointView = [s convertPoint:point fromView:self];//将自身坐标系转换到子视图中去
            NSLog(@"响应者子视图tag：%ld,子视图颜色：%@",s.tag,s.backgroundColor);
            //            UIView *p = [s hitTest:pointView withEvent:event];
            if ([s hitTest:pointView withEvent:event]) {
                return s;
            }
        }
        return nil;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL isPoint = [super pointInside:point withEvent:event];
    return isPoint;
}

@end

//
//  ViewController.m
//  005-计算机图像渲染原理
//
//  Created by gaoguangxiao on 2023/2/17.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /**
     计算机显示原理
     离屏渲染是机制 帧缓存储器是器件 卡顿是结果
     集成显卡 -> 独立显卡 帧缓存存储器 变化里程
     
     音视频的压缩编解码GPU
     图片CPU的解码：了解图片渲染流程
     
     图片撕裂产生原因
     
     卡顿、
     掉帧、下一个信号渲染之前 没有渲染完毕
     
     垂直同步 + 双缓冲区
     
     圆角 可能会产生离屏渲染
     阴影 遮罩 光栅
     边框颜色
     */
}


@end

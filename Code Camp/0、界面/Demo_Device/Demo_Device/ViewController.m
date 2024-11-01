//
//  ViewController.m
//  Demo_Device
//
//  Created by gaoguangxiao on 2022/5/30.
//

#import "ViewController.h"
#import "UIDevice+Height.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat statusHeight = UIDevice.currentDevice.HPStatusBarHeight;
    NSLog(@"状态栏高度：%f",statusHeight);
    
    CGFloat topBarHeight = UIDevice.currentDevice.HPTopBarHeight;
    NSLog(@"导航栏高度：%f",topBarHeight);
    
    //iPad mini4 有Home键
    /*
     2022-05-30 08:22:32.260541+0800 Demo_Device[13590:226677] 状态栏高度：20.000000
     2022-05-30 08:22:32.261261+0800 Demo_Device[13590:226677] 导航栏高度：70.000000
     **/
    
//    ipad mini6 没有home键
    /*
     2022-05-30 08:23:45.696701+0800 Demo_Device[13658:228555] 状态栏高度：24.000000
     2022-05-30 08:23:45.697139+0800 Demo_Device[13658:228555] 导航栏高度：74.000000
     **/
    
    
}


@end

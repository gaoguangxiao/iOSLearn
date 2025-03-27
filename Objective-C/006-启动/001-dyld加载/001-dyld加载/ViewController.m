//
//  ViewController.m
//  001-dyld加载
//
//  Created by 高广校 on 2025/3/21.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

+ (void)load {

    NSLog(@"走了load: %s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end

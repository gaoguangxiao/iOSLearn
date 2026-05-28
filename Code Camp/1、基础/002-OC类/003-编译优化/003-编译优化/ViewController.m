//
//  ViewController.m
//  003-编译优化
//
//  Created by gaoguangxiao on 2023/2/13.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    int a = 10;
    int b = 20;
    int c = [self addSum:a andB:b];
    NSLog(@"c = %d",c);
    
}

- (int)addSum:(int)a andB:(int)b {
    return a+ b;
}

@end

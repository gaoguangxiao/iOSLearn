//
//  ViewController.m
//  HitEvent
//
//  Created by gaoguangxiao on 2018/7/31.
//  Copyright © 2018年 gaoguangxiao. All rights reserved.
//

#import "ViewController.h"


#import "HitView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet HitView *redView;
@property (weak, nonatomic) IBOutlet HitView *blueView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap1:)];
//    [self.redView addGestureRecognizer:tap1];
//    
//    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap2:)];
//    [self.blueView addGestureRecognizer:tap2];
    
}
-(void)tap1:(UITapGestureRecognizer *)sender{
    NSLog(@"视图：%ld",sender.view.tag);
}
-(void)tap2:(UITapGestureRecognizer *)sender{
    NSLog(@"视图：%ld",sender.view.tag);
}
//- (IBAction)HitEvent:(UIButton *)sender {
//    NSLog(@"按钮%ld,按钮颜色：%@",sender.tag,sender.backgroundColor);
//}

- (IBAction)HitEvent:(UIControl *)sender {
    NSLog(@"视图：%ld",sender.tag);
}

- (IBAction)tap:(UITapGestureRecognizer *)sender {
     NSLog(@"视图：%ld",sender.view.tag);
}

//-hi

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

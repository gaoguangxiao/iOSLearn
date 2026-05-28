//
//  FViewController.m
//  005-KVO实现原理
//
//  Created by gaoguangxiao on 2023/2/18.
//

#import "FViewController.h"
#import "ViewController.h"
@interface FViewController ()

@end

@implementation FViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ViewController *Vc = [ViewController new];
    [self.navigationController pushViewController:Vc
                                         animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

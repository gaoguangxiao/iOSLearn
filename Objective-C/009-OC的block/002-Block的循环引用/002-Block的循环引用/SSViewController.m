//
//  SSViewController.m
//  Demo_Block
//
//  Created by gaoguangxiao on 2022/8/12.
//

#import "SSViewController.h"

typedef void(^KCBLock)(SSViewController *Vc);
@interface SSViewController ()

@property (nonatomic, copy) KCBLock block;

@property (nonatomic, copy) NSString *name;
@end

@implementation SSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.name = @"ggx";
    
   
    self.block = ^(SSViewController *Vc) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"你好%@",Vc.name);
        });
    };
    self.block(self);
}

- (void)methodTwo {
//    __block SSViewController *Vc = self;
//    self.block = ^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            NSLog(@"你好%@",Vc.name);
//            Vc = nil;
//        });
//    };
}

- (void)methodOne {
//    __weak typeof(self) weakSelf = self;
//    self.block = ^{
//        //1-测试
////        NSLog(@"%@",self.name);
////2、
////        NSLog(@"你好%@",weakSelf.name);
////        NSLog(@"你好");
//        //3-
//        __strong typeof(self) strongSelf = weakSelf;
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            NSLog(@"你好%@",strongSelf.name);
//        });
//    };
//    self.block();
}

- (void)dealloc {
    NSLog(@"%@--dealloc",self.class);
//    [super dealloc];
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

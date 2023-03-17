//
//  BViewController.m
//  Demo_pushVC
//
//  Created by gaoguangxiao on 2021/8/11.
//

#import "BViewController.h"
#import "ViewController.h"
@interface BViewController ()


@end

@implementation BViewController

__weak id reference = nil;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"B - viewWillAppear - 2");
    NSLog(@"viewWillAppear：%@",reference);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"B - viewDidAppear - 3");
    NSLog(@"viewDidAppear：%@",reference);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"B - viewDidDisappear -  5");
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"B - viewWillDisappear - 4");
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"B - viewDidLoad - 1");
    
    NSString *str = [NSString stringWithFormat:@"sunnyxx"];   // str是一个autorelease对象，设置一个weak的引用来观察它
    reference = str;
    
    // viewdidload viewwillappre viewdidaore viewwilldiaapp viewdiddisa deaoolc
}

//- (void)loadView {
//    NSLog(@"B - loadView");
//}

- (IBAction)POPAction:(id)sender {
    
//    [self dismissViewControllerAnimated:YES completion:^{
//
//    }];
    
//    ViewController *bv = [[ViewController alloc]init];
    
//    bv.delegate = self;
    
//    [self.navigationController pushViewController:bv animated:YES];
    
//    [self.navigationController popViewControllerAnimated:YES];
}


- (void)dealloc
{
    NSLog(@"B - dealloc - 6");
    NSLog(@"dealloc：%@",reference);
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

//
//  ViewController.m
//  Demo-MJExtension
//
//  Created by 高广校 on 2023/8/15.
//

#import "ViewController.h"
#import <MJExtension/MJExtension.h>
#import "MJPerson.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDictionary *dict = @{@"name":@"张三"};
    NSString *str = dict.mj_JSONString;
    
    MJPerson *p = [MJPerson mj_objectWithKeyValues:dict];
    
    NSDictionary *mjdict = p.mj_JSONObject;
    NSLog(@"%@",str);
}


@end

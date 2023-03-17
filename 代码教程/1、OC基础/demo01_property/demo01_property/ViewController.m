//
//  ViewController.m
//  demo01_property
//
//  Created by gaoguangxiao on 2023/2/12.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, assign) NSInteger age;//修饰基本类型 int float char

//@property (nonatomic, assign) char iphone;

@property (nonatomic, strong) NSString *name;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"start");
    
    //1、assign 修饰基本类型 不涉及内存管理。
//    不能修饰OC对象，容易报野指针错误。因为修饰的对象被销毁的时候，指针不会自动置为nil
    
    //retain
    
    //copy
    
    //strong
    
    //weak
    
    //no natomic
}

- (void)setName:(NSString *)name {
    if (_name != name) {
//        [_name release]; //release旧值
//        _name = [name copy];
    }
}
@end

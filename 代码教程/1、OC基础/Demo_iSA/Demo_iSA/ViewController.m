//
//  ViewController.m
//  Demo_iSA
//
//  Created by 高广校 on 2024/2/18.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic, strong) NSObject *obj1;
@property(nonatomic, strong) NSObject *obj2;
@property(nonatomic, weak) NSObject *weakRefObj;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSObject *obj = [NSObject alloc];
    _obj1 = obj;
    NSObject *tempObj = obj;
    NSLog(@"isa_t = %p", *(void **)(__bridge void*)obj);
    
//    p/t 0x3000001f16cc149
//    0b0000001100000000000000000000000111110001011011001100000101001001
//    从后向前看isa指针，第1位nonpointer，1代表不只是类对象地址，还包括类信息
//    后19位代表extra_rc,引用计数
}



@end

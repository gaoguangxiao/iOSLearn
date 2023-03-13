//
//  ViewController.m
//  006-深复制和浅复制
//
//  Created by gaoguangxiao on 2023/2/18.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSString copy之后 不可变 浅复制
//    mutablecopy 可变 深复制
//    可变字符 copy 深复制 mutableCopy
    NSMutableString *mstr = [NSMutableString stringWithString:@"adasd"];
//    [mstr copy];//深复制
//    [mstr mutableCopy];//深复制
    
//    数组
    NSArray *arr = @[@"1",@"2"];
    NSArray *arr1 = [arr copy];//浅
    NSMutableArray *arr3 = [arr mutableCopy];//深
    NSLog(@"%p-%p-%p",arr,arr1,arr3);
    
    //可变数组 mutable 深复制 指针地址 对象内存都复制一份
    
    //数组中 对数组复制，copy 原子类对象内存不发生变化，指针会复制一份
    
    //对象的复制 对象被深复制 但是里面属性是浅复制
    
    //数组 引用对象 copyItem:
    
}


@end

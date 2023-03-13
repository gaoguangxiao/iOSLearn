//
//  ViewController.m
//  004-KVC实现原理
//
//  Created by gaoguangxiao on 2023/2/17.
//

#import "ViewController.h"
#import "LGPerson.h"
#import "QMPerson.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //1、学习到
//    LGPerson *p = [[LGPerson alloc]init];
    /*
     [p setValue:@"ggx" forKey:@"name"];
     
     //没有这些成员变量 异常unde
     //什么情况会赋值
     //get属性先后顺序 _key _isKey key isKey 赋值的先后顺序
     NSLog(@"%@",p -> name);
 //    NSLog(@"%@",p -> _name);
     NSLog(@"%@",p -> isName);
     NSLog(@"%@",p -> _isName);
     */
    
    //2、类中没有 name 成员变量异常
//    QMPerson *q = [[QMPerson alloc]init];
//    [q setValue:@"ggx" forKey:@"name"];
    
        LGPerson *p = [[LGPerson alloc]init];
        [p valueForKey:@"name"];
    
    //get值的先后顺序
}


@end

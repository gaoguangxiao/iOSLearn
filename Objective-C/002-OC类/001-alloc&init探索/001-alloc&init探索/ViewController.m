//
//  ViewController.m
//  001-alloc&init探索
//
//  Created by gaoguangxiao on 2023/2/13.
//

#import "ViewController.h"
#import "LGPerson.h"

#ifdef DEBUG

#define LGNSLog()
#else

#endif

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSLog(format,...) printf("%s",[NSString string])
//    LGPerson *p1 = [LGPerson alloc];
//    LGPerson *p2 = [p1 init];
//    LGPerson *p3 = [p1 init];
//
//    //栈空间连续，一个指针8个字节
//    //alloc
//    NSLog(@"%@ %p %p",p1,p1,&p1);
//    NSLog(@"%@ %p %p",p2,p2,&p2);
//    NSLog(@"%@ %p %p",p3,p3,&p3);
    //内存大小计算 alloc
    LGPerson *objc = [[LGPerson alloc]init];
    objc.name = @"xiaoxiu";
    objc.nickName = @"xx";
    
//    NSLog(@"%@")
}


@end

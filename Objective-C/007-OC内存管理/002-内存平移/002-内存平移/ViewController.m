//
//  ViewController.m
//  002-内存平移
//
//  Created by gaoguangxiao on 2023/2/14.
//

#import "ViewController.h"
#import "LGPerson.h"

@interface ViewController ()

@property (nonatomic, strong) NSString *name;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    Class cls = [LGPerson class];
//    void *g = &cls;
//    [(__bridge id)g saySomething];// 对象方法（实例方法） 存在类中
//
//    LGPerson *p = [[LGPerson alloc]init];
//    [p saySomething];
    
    //setter 方法本质 新值retain
    self.name = @"ggx";
    //引用计数存在哪里
//    nonpointer
//    sidertable
    
}


@end

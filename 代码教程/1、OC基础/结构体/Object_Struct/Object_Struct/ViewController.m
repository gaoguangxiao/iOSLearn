//
//  ViewController.m
//  Object_Struct
//
//  Created by gaoguangxiao on 2022/9/13.
//

#import "ViewController.h"

struct OCDate {
    int year;
    int month;
    int day;
};

typedef struct OCTypeDate{
    int year;
    int month;
    int day;
}typeDate;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    struct OCDate date = {2022,9.10};
//    date.year = 2022;
//    date.month = 9;
//    date.day   = 23;
    NSLog(@"%d",date.year);
    
    struct OCTypeDate typedate = {2022,9.10};
    NSLog(@"%d",typedate.year);
    
    //1、结构体不能添加方法
    //2、值类型保存在栈上，效率较高。但属性太多的情况会影响效率
}


@end

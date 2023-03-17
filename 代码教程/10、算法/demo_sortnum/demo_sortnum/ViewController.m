//
//  ViewController.m
//  demo_sortnum
//
//  Created by gaoguangxiao on 2023/2/16.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSMutableArray *arr1 = @[@2,@3,@4,@5];
    NSMutableArray *arr2 = @[@1,@3,@6,@7];    
    NSMutableArray *muArr = [NSMutableArray new];
   
    //两个有序 -> 一个 有序的
    
    //1
//    [muArr addObjectsFromArray:arr1];
//    [muArr addObjectsFromArray:arr2];
//    nsd dec order 剩余
    
    /*
     //n 2n
         for (NSNumber *i in arr1) {
             
             NSInteger arr1i = [i integerValue];
     //        [muArr addObject:@(arr1i)];

             for (NSNumber *j in arr2) {
                 //1、某一个元素 j
                 NSInteger arr1j = [i integerValue];
                 //判断大小 muarr > == cont <
     //            if (arr1i < arr1j) {
     ////                [muArr addObject:@(arr1i)];
     //            }
                 //2、判断插入位置
                 NSInteger index = 0;
                 
     //            arr1j 在 muArr
                 
                 [muArr insertObject:@(arr1j) atIndex:index];
                 //插入位置
     //            [muArr addObject:@(arr1j)];
                //i
                 
             }
         }*/
    //集合 - 新数组
//    /runbloop mode 【def tachk cone】 time、 应用：线程、卡顿
    
//    q 0
    
//    time ac
//    CADisplayLink runlo
//    GCD timer 系统内核 准
    
//    tabl  cell timer nil = count【】
//    model count 倒计时
//
    
//    全局 cell 单例，倒计时 cell数-
    
//    多任务下载： 下载总量 10 40，-》get 预下载之前设计 get很多 【开启线程 】【记载 文件总量获取是否完毕】、[head] 响应文件 文件总量 nsin
//    flo-》
//    真实，开线 线程数 并发限制 n， blc del u3d
//     new 10url 文件路径，pro
    
//    mane 数据【1.23.344】，状态 单任务
//    resume 3
    
//    技术业务.
    
//
    
//    nsus
    

    
}

-(void)test {
    //线程常驻
//     NSThread
}


@end

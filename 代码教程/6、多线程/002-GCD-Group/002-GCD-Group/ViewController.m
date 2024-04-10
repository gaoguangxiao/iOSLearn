//
//  ViewController.m
//  002-GCD-Group
//
//  Created by 高广校 on 2023/8/10.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self testgroupa];
//    [self testgroupa2];
    [self testgroupa3];
}

- (void)testgroupa {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //创建线程组
    dispatch_group_t group = dispatch_group_create();
    //将任务添加队列
    dispatch_group_async(group, queue, ^{
        for (NSInteger i = 0; i < 100; i ++) {
            NSLog(@"____开始group1——%ld",(long)i);
        }
    });
    dispatch_group_async(group, queue, ^{
        for (NSInteger i = 0; i < 100; i ++) {
            NSLog(@"____开始group2——%ld",(long)i);
        }
    });
    
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"____end_group");
    });
    
    NSLog(@"任务执行");
}

- (void)testgroupa2 {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //创建线程组
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 100; i ++) {
            NSLog(@"____开始group1——%ld",(long)i);
        }
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 100; i ++) {
            NSLog(@"____开始group2——%ld",(long)i);
        }
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"____end_group");
    });
}

- (void)testgroupa3 {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //创建线程组
    dispatch_group_t group = dispatch_group_create();
    //将任务添加队列
    dispatch_group_async(group, queue, ^{
        for (NSInteger i = 0; i < 100; i ++) {
            NSLog(@"____开始group1——%ld",(long)i);
        }
    });
    dispatch_group_async(group, queue, ^{
        for (NSInteger i = 0; i < 100; i ++) {
            NSLog(@"____开始group2——%ld",(long)i);
        }
    });
    
    //会阻塞
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    NSLog(@"____end_group");

    
}
@end

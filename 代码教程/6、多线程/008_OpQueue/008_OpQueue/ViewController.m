//
//  ViewController.m
//  008_OpQueue
//
//  Created by 高广校 on 2023/8/14.
//

#import "ViewController.h"
#import "CGOpetaion.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSOperation *operation = [[NSOperation alloc]init];
    
//    [self testBlockOperation];
//    [self testBlockOperation1];
//    [self testBLockOperation2];
   
//    CGOpetaion *p = [[CGOpetaion alloc]init];
//    [p start];
    
//    [self testOperationQueue];
    [self testOperationQueue1];
//    NSBlockOperation *blockOperation = [NSBlockOperation alloc]blo
//    [NSOperationQueue mainQueue];
}

- (void)testOperationQueue {
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    // 方式1:
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        // 任务代码
        for (int i = 0; i < 5; i++) {
            sleep(1);
            NSLog(@"%d -- %@", i, NSThread.currentThread);
        }
    }];
    [queue addOperation:blockOperation];
}

- (void)testOperationQueue1 {
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    // 方式1:
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        // 任务代码
        for (int i = 0; i < 5; i++) {
            sleep(1);
            NSLog(@"%d -- %@", i, NSThread.currentThread);
        }
    }];
    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(testInvovationAction) object:nil];
    
//    [queue addOperation:blockOperation];
//    [queue addOperation:invocationOperation];
    
//    NSLog(@"开始执行");
    [queue addOperations:@[blockOperation,invocationOperation] waitUntilFinished:YES];
    NSLog(@"开始执行");
}

//
- (void)testBlockOperation {

    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"blockOperation开启:%@",[NSThread currentThread]);
    }];
    
    [blockOperation start];
    /*
     2023-08-15 15:19:38.195791+0800 008_OpQueue[14928:369647] blockOperation开启:<_NSMainThread: 0x600000978440>{number = 1, name = main}

     */
}

- (void)testBlockOperation1 {
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 5; i++) {
                sleep(2);
                NSLog(@"%d -- %@", i, NSThread.currentThread);
            }
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"addExecutionBlock1:%@", NSThread.currentThread);
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"addExecutionBlock2开启:%@",NSThread.currentThread);
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"addExecutionBlock3开启:%@",[NSThread currentThread]);
    }];
    [blockOperation start];
    /*
     2023-08-15 15:40:20.647274+0800 008_OpQueue[15540:394200] addExecutionBlock1:<NSThread: 0x600003fe0240>{number = 6, name = (null)}
     2023-08-15 15:40:20.647276+0800 008_OpQueue[15540:394201] addExecutionBlock2开启:<NSThread: 0x600003fa5280>{number = 5, name = (null)}
     2023-08-15 15:40:20.647282+0800 008_OpQueue[15540:394205] addExecutionBlock3开启:<NSThread: 0x600003ff4700>{number = 4, name = (null)}
     2023-08-15 15:40:22.648537+0800 008_OpQueue[15540:394035] 0 -- <_NSMainThread: 0x600003fa0440>{number = 1, name = main}
     2023-08-15 15:40:24.650347+0800 008_OpQueue[15540:394035] 1 -- <_NSMainThread: 0x600003fa0440>{number = 1, name = main}

     */
}

- (void)testBLockOperation2 {
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        // 任务代码
        for (int i = 0; i < 5; i++) {
            sleep(2);
            NSLog(@"%d -- %@", i, NSThread.currentThread);
        }
    }];
        
    [blockOperation addExecutionBlock:^{
        NSLog(@"addExecutionBlock1:%@", NSThread.currentThread);
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"addExecutionBlock2:%@", NSThread.currentThread);
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"addExecutionBlock3:%@", NSThread.currentThread);
    }];
    [blockOperation start];
}

- (void)testInvovationOperation {
    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(testInvovationAction) object:nil];
    [invocationOperation start];
}

//单独使用NSInvocationOperation，并没有开启线程，需要手动start
- (void)testInvovationAction {
    NSLog(@"开启:%@",[NSThread currentThread]);
    /*
     2023-08-15 15:16:40.288216+0800 008_OpQueue[14827:365570] 开启:<_NSMainThread: 0x600000cd0440>{number = 1, name = main}
*/
}

@end

//
//  ViewController.m
//  003-GCD-Barrier
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
    
//    [self testGCDBarrier];
    [self testGCDBarrier1];
//    [self testGCDBarrier2];
//    [self testGCDBarrierS];
//    [self testGCDBarrierG1];
}

- (void)testGCDBarrier {
    dispatch_queue_t queue = dispatch_queue_create("com.wynter.customQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"async_%ld",i);
        }
    });
    dispatch_barrier_async(queue, ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"barri_%ld",i);
        }
    });
    dispatch_async(queue, ^{
       NSLog(@"%@", [NSThread currentThread]);
    });
    /*
     栅栏函数之前任务优先执行
     2023-08-10 14:15:58.058243+0800 003-GCD-Barrier[1911:18684] async_0
     2023-08-10 14:15:58.058291+0800 003-GCD-Barrier[1911:18684] async_1
     2023-08-10 14:15:58.058327+0800 003-GCD-Barrier[1911:18684] async_2
     2023-08-10 14:15:58.058361+0800 003-GCD-Barrier[1911:18684] barri_0
     2023-08-10 14:15:58.058393+0800 003-GCD-Barrier[1911:18684] barri_1
     2023-08-10 14:15:58.058420+0800 003-GCD-Barrier[1911:18684] barri_2
     2023-08-10 14:15:58.058498+0800 003-GCD-Barrier[1911:18684] <NSThread: 0x600003d2cb80>{number = 5, name = (null)}
     */
}

- (void)testGCDBarrier1 {
    dispatch_queue_t queue = dispatch_queue_create("com.wynter.customQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"async_%ld",i);
        }
    });
    dispatch_barrier_sync(queue, ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"barri_%ld",i);
        }
    });
    dispatch_async(queue, ^{
       NSLog(@"%@", [NSThread currentThread]);
    });
    NSLog(@"栅栏函数-并发队列-同步");
    /*
     2023-08-14 17:52:17.545740+0800 003-GCD-Barrier[19779:411069] async_0
     2023-08-14 17:52:17.545807+0800 003-GCD-Barrier[19779:411069] async_1
     2023-08-14 17:52:17.545845+0800 003-GCD-Barrier[19779:411069] async_2
     2023-08-14 17:52:17.545903+0800 003-GCD-Barrier[19779:410886] barri_0
     2023-08-14 17:52:17.545941+0800 003-GCD-Barrier[19779:410886] barri_1
     2023-08-14 17:52:17.545982+0800 003-GCD-Barrier[19779:410886] barri_2
     2023-08-14 17:52:17.546040+0800 003-GCD-Barrier[19779:410886] 栅栏函数-并发队列-同步
     2023-08-14 17:52:17.546063+0800 003-GCD-Barrier[19779:411069] <NSThread: 0x6000001d4180>{number = 3, name = (null)}

     */
}

- (void)testGCDBarrier2 {
    dispatch_queue_t queue = dispatch_queue_create("com.wynter.customQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue1 = dispatch_queue_create("com.wynter.customQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"async_%ld",i);
        }
    });
    dispatch_barrier_async(queue1, ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"barri_%ld",i);
        }
    });
    dispatch_async(queue, ^{
       NSLog(@"%@", [NSThread currentThread]);
    });
    NSLog(@"栅栏函数");
    /*
     线程打印，可见并没有拦截 <NSThread: 0x60000183ad00>{number = 6, name = (null)} 的打印
     2023-08-10 14:11:19.926740+0800 003-GCD-Barrier[17231:302943] 栅栏函数
     2023-08-10 14:11:19.926742+0800 003-GCD-Barrier[17231:303434] async_0
     2023-08-10 14:11:19.926747+0800 003-GCD-Barrier[17231:303436] barri_0
     2023-08-10 14:11:19.926762+0800 003-GCD-Barrier[17231:303433] <NSThread: 0x60000183ad00>{number = 6, name = (null)}
     2023-08-10 14:11:19.926785+0800 003-GCD-Barrier[17231:303434] async_1
     2023-08-10 14:11:19.926808+0800 003-GCD-Barrier[17231:303436] barri_1
     2023-08-10 14:11:19.926827+0800 003-GCD-Barrier[17231:303434] async_2
     2023-08-10 14:11:19.926852+0800 003-GCD-Barrier[17231:303436] barri_2
     */
}

- (void)testGCDBarrierS {
    dispatch_queue_t queue = dispatch_queue_create("com.wynter.customQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"async1_%ld",i);
        }
    });
    //异步串行-开线程
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"async2_%ld",i);
        }
    });
    dispatch_barrier_async(queue, ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"barri_%ld",i);
        }
    });
    dispatch_async(queue, ^{
       NSLog(@"%@", [NSThread currentThread]);
    });
    NSLog(@"栅栏函数-串行队列-测试拦截");
    /*
     串行队列，栅栏函数并没有拦截，
     2023-08-10 14:28:29.934823+0800 003-GCD-Barrier[2520:36751] 栅栏函数-串行队列-测试拦截
     2023-08-10 14:28:29.934825+0800 003-GCD-Barrier[2520:36919] async1_0
     2023-08-10 14:28:29.934872+0800 003-GCD-Barrier[2520:36919] async1_1
     2023-08-10 14:28:29.934902+0800 003-GCD-Barrier[2520:36919] async1_2
     2023-08-10 14:28:29.934935+0800 003-GCD-Barrier[2520:36919] async2_0
     2023-08-10 14:28:29.934966+0800 003-GCD-Barrier[2520:36919] async2_1
     2023-08-10 14:28:29.934996+0800 003-GCD-Barrier[2520:36919] async2_2
     2023-08-10 14:28:29.935050+0800 003-GCD-Barrier[2520:36919] barri_0
     2023-08-10 14:28:29.935089+0800 003-GCD-Barrier[2520:36919] barri_1
     2023-08-10 14:28:29.935128+0800 003-GCD-Barrier[2520:36919] barri_2
     2023-08-10 14:28:29.935235+0800 003-GCD-Barrier[2520:36919] <NSThread: 0x6000001702c0>{number = 6, name = (null)}
     */
}
- (void)testGCDBarrierG1 {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"async_%ld",i);
        }
    });
    dispatch_barrier_async(queue, ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"barri_%ld",i);
        }
    });
    
    dispatch_async(queue, ^{
       NSLog(@"%@", [NSThread currentThread]);
    });
    NSLog(@"栅栏函数-全局队列");
    /*
     可见并全局队列也是拦不住，只能是自定义的并发队列
     2023-08-10 14:19:44.797890+0800 003-GCD-Barrier[2172:24015] 栅栏函数-全局队列
     2023-08-10 14:19:44.797896+0800 003-GCD-Barrier[2172:24192] async_0
     2023-08-10 14:19:44.797905+0800 003-GCD-Barrier[2172:24193] barri_0
     2023-08-10 14:19:44.797922+0800 003-GCD-Barrier[2172:24188] <NSThread: 0x60000290c3c0>{number = 4, name = (null)}
     2023-08-10 14:19:44.797944+0800 003-GCD-Barrier[2172:24192] async_1
     2023-08-10 14:19:44.797952+0800 003-GCD-Barrier[2172:24193] barri_1
     2023-08-10 14:19:44.797974+0800 003-GCD-Barrier[2172:24192] async_2
     2023-08-10 14:19:44.797983+0800 003-GCD-Barrier[2172:24193] barri_2

     */
}
@end

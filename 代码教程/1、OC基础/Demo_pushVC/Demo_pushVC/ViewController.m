//
//  ViewController.m
//  Demo_pushVC
//
//  Created by gaoguangxiao on 2021/8/11.
//

#import "ViewController.h"
#import "BViewController.h"
#import "A.h"
@interface ViewController ()

@property (atomic,assign) NSInteger textAdd;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"A - viewWillAppear - load - 2 - 7");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"A - viewDidAppear - load - 3 - 9");
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"A - viewDidDisappear - 4");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"A - viewWillDisappear - 2");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"A - viewDidLoad - load - 1");
    
    A *a = [[A alloc]initWithFrame:CGRectMake(0, 100, 100, 100)];
    a.backgroundColor = [UIColor redColor];
    [self.view addSubview:a];
    
//    NSArray *arr = @[@1,@2,@5,@7];
//    int  target = 7;
//    NSMutableArray *mArr = [NSMutableArray new];
//    for (int i=0;i <arr.count;i++){
//        int value = [arr[i] intValue];
//        for (int j = i + 1; j < arr.count;j++){
//           int jvalue = [arr[j] intValue];
//           int sums =  value +  jvalue;
//           if (sums == target){
//            [mArr addObject:@(i)];
//            [mArr addObject:@(j)];
//          }
//        }
//    }
//    NSLog(@"%@",mArr);

    
    NSArray *arr = @[@1,@2,@5,@7];
    int  target = 7;
    NSMutableArray *mArr = [NSMutableArray new];
    for (int i=0;i <arr.count;i++){
        int value = [arr[i] intValue];
        for (int j = i + 1; j < arr.count;j++){
           int jvalue = [arr[j] intValue];
           int sums =  value +  jvalue;
           if (sums == target){
            [mArr addObject:@(i)];
            [mArr addObject:@(j)];
          }
        }
    }
    NSLog(@"%@",mArr);

    
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(queue, ^{
//
//        for (int i = 0; i < 50000; i++) {
//
//             NSObject *obj = [[NSObject alloc] init];  // 内存暴增，局部变量没有释放
//            self.textAdd ++;
//            NSLog(@"queue-%ld",self.textAdd);
//        }
//    });
//
//    dispatch_queue_t queue1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(queue1, ^{
//
//        for (int i = 0; i < 50000; i++) {
//
//             NSObject *obj = [[NSObject alloc] init];  // 内存暴增，局部变量没有释放
//
//            self.textAdd ++;
//            NSLog(@"queue1-%ld",self.textAdd);
//        }
//
//    });
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSLog(@"queueAl-%ld",self.textAdd);
//    });
}
- (IBAction)push:(id)sender {
    
    
    
    BViewController *bv = [[BViewController alloc]init];
    
//    bv.delegate = self;
    
    [self.navigationController pushViewController:bv animated:YES];
    
}

- (void)dealloc {
    
}

- (void)dosomething {
    NSLog(@"做某件事情");
}

@end

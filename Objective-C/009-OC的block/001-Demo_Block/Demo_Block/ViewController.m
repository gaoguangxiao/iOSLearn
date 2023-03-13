//
//  ViewController.m
//  Demo_Block
//
//  Created by gaoguangxiao on 2022/4/20.
//

#import "ViewController.h"
#import "WeakModel.h"

@interface ViewController ()
{
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //栈block
//    NSString *name = @"ggx";
//    void (^block)(void) = ^{
//        NSLog(@"%@：team",name);
//    };
    
    
    int age = 19;
//    void (^did)(void)= ^{
//        NSLog(@"%d",age);
//    };
////    did();
//    NSLog(@"%@",did);// 堆 mallocblock
    
    //
//    void (^did)(int a) = ^(int q){
//        NSLog(@"%@",q);
//    };
//    NSLog(@"%@",did);//堆
//
//    //取别名
    NSLog(@"%@",^{
        NSLog(@"%d",age);
    });
    
    [self test];
    
//    NSLog(@"s:%@",s);
}

- (void)test {
//    s = [NSString stringWithFormat:@"ggx"];
    //下面这句代码，用weak修饰，引用计数-1，创建之后就会释放掉
//     WeakModel *s = [[WeakModel alloc]init];
    NSObject *obj = [[NSObject alloc]init];
    NSLog(@"1 - stongBlock：%ld",CFGetRetainCount((__bridge CFTypeRef)(obj)));
    void (^stongBlock)(void) = ^{
        NSLog(@"3 - stongBlock：%ld",CFGetRetainCount((__bridge CFTypeRef)(obj)));
    };
    NSLog(@"2 - stongBlock：%ld",CFGetRetainCount((__bridge CFTypeRef)(obj)));
    stongBlock();
    
    //下面两句代码一样，默认strong修饰
//    WeakModel *defaults = [[WeakModel alloc]init];
//    [defaults release];
    
//    __strong WeakModel *strongs = [[WeakModel alloc]init];
    
//    NSLog(@"s:%d,defaults:%d,strongs:%d",s.retainCount,defaults.retainCount,strongs.retainCount);
}
@end

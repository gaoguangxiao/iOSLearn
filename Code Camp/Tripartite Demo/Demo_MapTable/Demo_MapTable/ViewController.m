//
//  ViewController.m
//  Demo_MapTable
//
//  Created by 高广校 on 2023/8/14.
//

#import "ViewController.h"
#import "MTPerson.h"
#import "MTMan.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self testDic];
    
    [self testMapTale];
}

- (void)testDic {

    NSMutableDictionary *mDic = [NSMutableDictionary new];
    
    MTPerson *mt = [[MTPerson alloc]init];
    MTMan *mtm = [[MTMan alloc]init];
    
    [mDic setObject:@"MT1" forKey:mt];
    [mDic setObject:@"MT2" forKey:mt];
    
    NSLog(@"NSMutableDictionary:%@",mDic);
}

- (void)testMapTale {
    
    NSMapTable *mpt = [[NSMapTable alloc]initWithKeyPointerFunctions:NSPointerFunctionsWeakMemory valuePointerFunctions:NSPointerFunctionsStrongMemory capacity:2];
//    MTPerson *mt = [[MTPerson alloc]init];
//    MTMan *mtm = [[MTMan alloc]init];
//
//    [mpt setObject:mtm forKey:mt];
//    [mpt setObject:@"MT" forKey:mt];
//
//    NSLog(@"NSMapTable:%@",mpt);
}

- (void)mapTableTest {
    self.mapTable = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsCopyIn valueOptions:NSPointerFunctionsWeakMemory capacity:10];
    NSObject *obj1 = [[NSObject alloc] init];
    NSObject *obj2 = [[NSObject alloc] init];
    NSObject *obj3 = [[NSObject alloc] init];
    NSObject *obj4 = [[NSObject alloc] init];
    NSObject *obj5 = obj4;
    
    [self.mapTable setObject:obj1 forKey:@"obj1"];
    [self.mapTable setObject:obj2 forKey:@"obj2"];
    [self.mapTable setObject:obj3 forKey:@"obj3"];
    [self.mapTable setObject:obj4 forKey:@"obj4"];
    [self.mapTable setObject:obj5 forKey:@"obj5"];
    
    NSLog(@"Members: %@", self.mapTable);
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.backgroundColor = [UIColor redColor];
    btn2.frame = CGRectMake(100, 100, 100, 100);
    [btn2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
}
- (void)btn2Click {
    NSLog(@"Members: %@", self.mapTable);
}
@end

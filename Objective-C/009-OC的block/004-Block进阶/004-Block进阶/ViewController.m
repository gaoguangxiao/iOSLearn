//
//  ViewController.m
//  004-Block进阶
//
//  Created by gaoguangxiao on 2023/2/13.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    __block int age = 19;
    void (^did)(void)= ^{
        age++;
    };
    did();
    
    
    //1、block是一个结构体对象
//    struct {
    //
//    block_main_impl_0 {} 结构体
//    block_main_fun( 传递结构体看，修饰的变量__block结构体);
    
    //2、block具备保存代码块的功能 保存了一个函数
//    impl.funPto = fp;
    
//    main_block_implo
    //3、__block 是结构体指针传递；没有为值传递
    //4、自动捕获变量 结构体增加变量
    
    
    
}


@end

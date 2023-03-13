//
//  ViewController.m
//  005-KVO实现原理
//
//  Created by gaoguangxiao on 2023/2/18.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "LGPerson.h"
@interface ViewController ()

@property (nonatomic, strong) LGPerson *p;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //    可观察属性 不可观察成员变量
    //    了解KVO派生类的生成过程 以及里面方法
    //    销毁
    
    //    self.p = LGPerson
    
    //动态生成 NSKVO_Notifying_类
    self.p = [[LGPerson alloc]init];
    
    [self printClasses:self.p.class];
    
    [self.p addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    [self printClasses:self.p.class];
    /*
     LGPerson,
     "NSKVONotifying_LGPerson"
     */
    
    Class cls = NSClassFromString(@"NSKVONotifying_LGPerson");
    [self printClassAllMethod:cls];
    
    self.p.name = @"gg";
    
//lldb 调试
    
    
    //提问
//    KVO的内部实现 简述过程
//   观察成员变量，可以观察到值的变化吗？通过 kvc的赋值
    
//    KVO：一对一，需要销毁，基于KVC
//    代理：一对一 options关键词 正反向传值 写起来麻烦
//    通知：一对多 移除
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    
}

- (void)dealloc
{
    [self.p removeObserver:self forKeyPath:@"name"];
    
    //验证是否被销毁
    [self printClasses:self.p.class];
    NSLog(@"%@--dealloc",self);
}

//打印当前类的所有方法
- (void)printClassAllMethod:(Class)cls {
   unsigned int count = 0;
    Method *methodList = class_copyMethodList(cls, &count);
    for (int i = 0; i < count ;i++) {
        Method method = methodList[i];
        SEL sel = method_getName(method);//方法名字
        IMP imp = class_getMethodImplementation(cls, sel);
        NSLog(@"%@-%p",NSStringFromSelector(sel),imp);
    }
    free(methodList);
}

- (void)printClasses:(Class)cls {
    int count = objc_getClassList(NULL, 0);
    NSMutableArray *mA = [NSMutableArray arrayWithObject:cls];
    Class *classes = (Class *)malloc(sizeof(Class) * count);
    objc_getClassList(classes, count);
    for (int i = 0; i < count ;i++) {
        if (cls == class_getSuperclass(classes[i])) {
            [mA addObject:classes[i]];
        }
    }
    free(classes);
    NSLog(@"%@",mA);
}

@end

//
//  ViewController.m
//  BlockRetainCycleDemo - Block性能优化Demo
//
//  Created by gaoguangxiao on 2023/2/15.
//

#import "ViewController.h"
#import "LGTeacher.h"
#import "BlockRetainCycleVC.h"

/**
 Block 性能优化要点（含 Swift 对比）
 
 一、Block 的三种类型（内存位置不同）
 - _NSConcreteGlobalBlock（全局区）：不捕获外部变量
 - _NSConcreteStackBlock（栈区）：捕获外部变量，未拷贝
 - _NSConcreteMallocBlock（堆区）：栈 block 被 copy 后移到堆
 
 二、循环引用（内存泄漏主因）
 1. self -> block -> self（经典循环）
 2. self -> block -> self.xxx（隐式强引用）
 3. 多层 block 嵌套（延迟执行中的强引用链）
 
 三、优化策略
 1. __weak + __strong：打破循环，延迟执行时保证安全
 2. 用参数传递替代捕获：减少 block 捕获变量的开销
 3. 避免大对象捕获：仅捕获需要的属性而非整个 self
 4. 栈 block 自动拷贝性能：频繁传递时主动 copy
 5. __block 的优化：避免 __block 修饰大对象
 */

@interface ViewController ()

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) void(^holdBlock)(void);

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Block内存优化";
    self.name = @"Block性能优化";

    [self setupNavigationButtons];

    [self demoBlockType];
    [self demoRetainCycle];
    [self demoCaptureOptimize];
    [self demoBlockKeyword];
}

#pragma mark - 跳转演示
- (void)setupNavigationButtons {
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn1.frame = CGRectMake(40, 100, 300, 44);
    [btn1 setTitle:@"Push: 循环引用（不会销毁）" forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn1 addTarget:self action:@selector(pushRetainCycleVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];

    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn2.frame = CGRectMake(40, 160, 300, 44);
    [btn2 setTitle:@"Push: 使用weak（会销毁）" forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn2 addTarget:self action:@selector(pushWeakSelfVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

- (void)pushRetainCycleVC {
    BlockRetainCycleVC *vc = [[BlockRetainCycleVC alloc] init];
    vc.useWeakSelf = NO;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushWeakSelfVC {
    BlockRetainCycleVC *vc = [[BlockRetainCycleVC alloc] init];
    vc.useWeakSelf = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 1. Block 三种类型
- (void)demoBlockType {
    NSLog(@"\n========== 1. Block 类型验证 ==========");
    
    // 全局 Block：不捕获外部变量
    void (^globalBlock)(void) = ^{
        NSLog(@"全局 Block - 在全局区");
    };
    NSLog(@"全局 Block: %@", [globalBlock class]);
    // 输出: __NSGlobalBlock__
    
    // 栈 Block：捕获自动变量（MRC 下在栈，ARC 下自动 copy 到堆）
    int temp = 10;
    void (^stackBlock)(void) = ^{
        NSLog(@"捕获了外部变量: %d", temp);
    };
    NSLog(@"ARC 下自动成堆 Block: %@", [stackBlock class]);
    // ARC 输出: __NSMallocBlock__ （ARC 自动 copy）
    
    // 手动展示栈 Block（需要 MRC 或使用 __weak 阻止 copy）
    __weak void (^weakBlock)(void) = ^{
        NSLog(@"被 weak 引用 - %d", temp);
    };
    NSLog(@"weak 持有的栈 Block: %@", [weakBlock class]);
    // 输出: __NSStackBlock__
}

#pragma mark - 2. 循环引用优化
- (void)demoRetainCycle {
    NSLog(@"\n========== 2. 循环引用优化 ==========");
    
    // ❌ 错误：循环引用
    // self -> holdBlock -> self
    __weak typeof(self) weakSelf = self;
    self.holdBlock = ^{
        // ✅ 正确：使用 weakSelf
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            NSLog(@"weak + strong 模式：%@", strongSelf.name);
        }
    };
    self.holdBlock();
    
    // 优化示范：用参数传递替代捕获
    LGTeacher *teacher = [[LGTeacher alloc] init];
    teacher.name = @"优化示范";
    [self doWorkWithParam:teacher block:^(LGTeacher *t) {
        // 通过参数传递，不捕获外部变量
        // 减少 block 结构体大小，降低内存开销
        NSLog(@"参数传递模式：%@", t.name);
    }];
}

- (void)doWorkWithParam:(LGTeacher *)teacher block:(void(^)(LGTeacher *))block {
    if (block) {
        block(teacher);
    }
}

#pragma mark - 3. 捕获优化
- (void)demoCaptureOptimize {
    NSLog(@"\n========== 3. 捕获开销优化 ==========");
    
    // ❌ 大开销：捕获整个大对象
    // 分析：如果 self 很大，block 会持有整个 self
    void (^badCapture)(void) = ^{
        NSLog(@"🍎 大量捕获 - self.name: %@", self.name);
    };
    badCapture();
    NSLog(@"badCapture size cost: 大（因为持有整个 self）");
    
    // ✅ 优化：只捕获需要的属性（值类型）
    NSString *localName = [self.name copy];
    void (^goodCapture)(void) = ^{
        NSLog(@"✅ 优化捕获 - name: %@", localName);
    };
    goodCapture();
    NSLog(@"goodCapture size cost: 小（仅捕获 NSString）");
    
    // 性能对比：减少 block 结构体大小
    // 每多捕获一个对象，block 结构体增加 8 字节（指针大小）
    // 捕获多个对象 → block 变大 → copy 开销变大
}

#pragma mark - 4. __block 使用注意
- (void)demoBlockKeyword {
    NSLog(@"\n========== 4. __block 优化 ==========");
    
    // __block 的本质：将变量包装成 __Block_byref_xxx 结构体（在堆上）
    // 这意味着额外一次堆内存分配和释放
    
    // ✅ 适合用 __block 的场景
    __block int counter = 0;
    void (^counterBlock)(void) = ^{
        counter++;
    };
    counterBlock();
    NSLog(@"__block counter = %d", counter);
    
    // ❌ 避免对大对象使用 __block
    // __block LGTeacher *bigObj; // 大对象会额外包装，多一层间接引用
    
    // ✅ 更好的做法：用 __weak + 参数传递
    LGTeacher *teacher = [[LGTeacher alloc] init];
    teacher.name = @"不要用__block修饰大对象";
    [self doWorkWithParam:teacher block:^(LGTeacher *t) {
        NSLog(@"参数传递替代 __block: %@", t.name);
    }];
}

#pragma mark - 性能优化总结
/**
 
 🚀 Block 性能优化 Checklist:
 
 1. 循环引用检测
    □ 检查 block 属性是否用 copy（MRC）或 strong（ARC 自动 copy）
    □ 检查 block 内是否有 self.xxx → 用 weakSelf + strongSelf
    □ 检查多层 block 嵌套的引用链
 
 2. 内存开销
    □ 优先用参数传递替代捕获
    □ 只捕获需要的最小对象
    □ __block 仅用在需要修改变量的场景，避免对大对象使用
 
 3. 执行性能
    □ 频繁传递的 block 主动 copy 一次（避免多次栈→堆拷贝）
    □ 避免在 block 内执行耗时操作（block 可能被持有较长时间）
    □ 及时释放不再需要的 block 属性（赋 nil）
 
 4. Swift 中对应的概念
    □ OC Block = Swift Closure
    □ __weak = [weak self]
    □ __strong = guard let strongSelf = self
    □ 参数传递捕获 = capture list 传参
 */

- (void)dealloc {
    NSLog(@"ViewController dealloc ✅ - 无循环引用");
}

@end

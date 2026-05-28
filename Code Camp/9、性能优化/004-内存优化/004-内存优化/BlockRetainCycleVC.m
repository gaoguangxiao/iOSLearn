//
//  BlockRetainCycleVC.m
//  BlockRetainCycleDemo
//
//  Created by gaoguangxiao on 2023/2/15.
//

#import "BlockRetainCycleVC.h"

typedef void(^CompletionBlock)(void);

@interface BlockRetainCycleVC ()

@property (nonatomic, copy) CompletionBlock completionBlock;
@property (nonatomic, copy) NSString *name;

@end

@implementation BlockRetainCycleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.name = @"BlockRetainCycleVC";

    if (self.useWeakSelf) {
        self.title = @"使用weak（会销毁）";
        [self setupWithWeak];
    } else {
        self.title = @"循环引用（不会销毁）";
        [self setupRetainCycle];
    }
}

#pragma mark - 循环引用：self -> completionBlock -> self
- (void)setupRetainCycle {
    self.completionBlock = ^{
        NSLog(@"block 持有了 self: %@", self.name);
    };
    self.completionBlock();

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 200, 300, 100)];
    label.numberOfLines = 0;
    label.text = @"❌ 存在循环引用\nself -> block -> self\n返回后 dealloc 不会调用";
    label.textColor = [UIColor redColor];
    [self.view addSubview:label];
}

#pragma mark - 使用 __weak 打破循环引用
- (void)setupWithWeak {
    __weak typeof(self) weakSelf = self;
    self.completionBlock = ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            NSLog(@"weak+strong 模式: %@", strongSelf.name);
        }
    };
    self.completionBlock();

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 200, 300, 100)];
    label.numberOfLines = 0;
    label.text = @"✅ 使用 __weak 打破循环引用\nself -> block -> weakSelf\n返回后 dealloc 会调用";
    label.textColor = [UIColor systemGreenColor];
    [self.view addSubview:label];
}

- (void)dealloc {
    NSLog(@"🔥 %@ dealloc - 控制器已销毁", NSStringFromClass([self class]));
}

@end

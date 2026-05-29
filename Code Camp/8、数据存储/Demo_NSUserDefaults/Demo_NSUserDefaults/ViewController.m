//
//  ViewController.m
//  Demo_NSUserDefaults
//
//  Created by gaoguangxiao on 2024/6/13.
//  Copyright © 2024 gaoguangxiao. All rights reserved.
//
//  面试考点：NSUserDefaults 的实现原理、存储机制、线程安全、性能特点

#import "ViewController.h"

// 自定义对象，用于测试归档存储
@interface Person : NSObject <NSCoding>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;
@end

@implementation Person

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeInteger:self.age forKey:@"age"];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        _name = [coder decodeObjectForKey:@"name"];
        _age = [coder decodeIntegerForKey:@"age"];
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Person{name=%@, age=%ld}", self.name, (long)self.age];
}

@end

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, strong) NSMutableString *log;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"NSUserDefaults 面试考点";
    self.log = [NSMutableString string];
    
    [self demo1_basicUsage];              // 1. 基本读写
    [self demo2_supportedTypes];          // 2. 支持的数据类型
    [self demo3_customObject];            // 3. 自定义对象存储
    [self demo4_synchronize];             // 4. synchronize 机制
    [self demo5_registerDefaults];        // 5. 注册默认值
    [self demo6_suiteName];               // 6. App Group 共享
    [self demo7_threadSafety];            // 7. 线程安全
    [self demo8_performance];             // 8. 性能特点
    [self demo9_plistLocation];           // 9. 存储位置
    [self demo10_removeObserver];         // 10. KVO 监听
    
    [self showLog];
}

#pragma mark - 1. 基本读写
- (void)demo1_basicUsage {
    [self appendTitle:@"1. 基本读写"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // 写入
    [defaults setObject:@"张三" forKey:@"userName"];
    [defaults setInteger:25 forKey:@"userAge"];
    [defaults setBool:YES forKey:@"isVip"];
    [defaults setFloat:1.75 forKey:@"height"];
    [defaults setDouble:65.5 forKey:@"weight"];
    [defaults setURL:[NSURL URLWithString:@"https://apple.com"] forKey:@"homepage"];
    
    // 读取
    NSString *name = [defaults objectForKey:@"userName"];
    NSInteger age = [defaults integerForKey:@"userAge"];
    BOOL isVip = [defaults boolForKey:@"isVip"];
    CGFloat height = [defaults floatForKey:@"height"];
    double weight = [defaults doubleForKey:@"weight"];
    NSURL *url = [defaults URLForKey:@"homepage"];
    
    [self appendLog:@"setObject:forKey: 写入 userName=张三"];
    [self appendLog:@"setInteger:forKey: 写入 userAge=25"];
    [self appendLog:@"setBool:forKey: 写入 isVip=YES"];
    [self appendLog:@"读取: name=%@, age=%ld, isVip=%d", name, (long)age, isVip];
    [self appendLog:@"读取: height=%.2f, weight=%.1f, url=%@", height, weight, url];
    [self appendLog:@"考点: 支持 NSString/NSNumber/NSData/NSDate/NSArray/NSDictionary"];
    [self appendLog:@""];
}

#pragma mark - 2. 支持的数据类型
- (void)demo2_supportedTypes {
    [self appendTitle:@"2. 支持的数据类型（Plist 可序列化类型）"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // 支持的类型
    [defaults setObject:@"string" forKey:@"type_string"];
    [defaults setObject:@(123) forKey:@"type_number"];
    [defaults setObject:[NSData data] forKey:@"type_data"];
    [defaults setObject:[NSDate date] forKey:@"type_date"];
    [defaults setObject:@[@"a", @"b"] forKey:@"type_array"];
    [defaults setObject:@{@"key": @"value"} forKey:@"type_dict"];
    
    [self appendLog:@"支持6种Plist类型: NSString/NSNumber/NSData/NSDate/NSArray/NSDictionary"];
    [self appendLog:@"不支持: UIColor/UIImage/CGRect 等非Plist类型"];
    [self appendLog:@"考点: 自定义对象需转 NSData 后存储"];
    [self appendLog:@""];
}

#pragma mark - 3. 自定义对象存储
- (void)demo3_customObject {
    [self appendTitle:@"3. 自定义对象存储（NSCoding 归档）"];
    
    Person *person = [[Person alloc] init];
    person.name = @"李四";
    person.age = 30;
    
    // 归档为 NSData
    NSError *error = nil;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:person requiringSecureCoding:NO error:&error];
    if (data) {
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"person"];
        [self appendLog:@"自定义 Person 对象归档为 NSData 后存储 ✅"];
    } else {
        [self appendLog:@"归档失败: %@", error.localizedDescription];
    }
    
    // 解档读取
    NSData *savedData = [[NSUserDefaults standardUserDefaults] objectForKey:@"person"];
    Person *savedPerson = [NSKeyedUnarchiver unarchivedObjectOfClass:[Person class] fromData:savedData error:nil];
    [self appendLog:@"读取: %@", savedPerson];
    [self appendLog:@"考点: 自定义类需实现 NSCoding 协议，通过 NSKeyedArchiver 转 NSData"];
    [self appendLog:@""];
}

#pragma mark - 4. synchronize 机制
- (void)demo4_synchronize {
    [self appendTitle:@"4. synchronize 机制"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"testSync" forKey:@"syncKey"];
    
    [self appendLog:@"setObject:forKey: 只写入内存字典，不立即写磁盘"];
    [self appendLog:@"synchronize: 强制将内存修改同步到磁盘 plist 文件"];
    [defaults synchronize];
    [self appendLog:@"已调用 synchronize ✅"];
    [self appendLog:@"iOS 8+ 系统会定期自动同步，但重要数据建议手动调用"];
    [self appendLog:@"考点: synchronize 不是每次 set 都写磁盘，而是批量写入减少 IO"];
    [self appendLog:@""];
}

#pragma mark - 5. 注册默认值
- (void)demo5_registerDefaults {
    [self appendTitle:@"5. 注册默认值（registerDefaults）"];
    
    // registerDefaults 不会覆盖已存在的值
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{
        @"fontSize": @14,
        @"theme": @"light",
        @"autoLogin": @NO
    }];
    
    NSInteger fontSize = [[NSUserDefaults standardUserDefaults] integerForKey:@"fontSize"];
    NSString *theme = [[NSUserDefaults standardUserDefaults] stringForKey:@"theme"];
    
    [self appendLog:@"registerDefaults 注册默认值: fontSize=14, theme=light"];
    [self appendLog:@"读取: fontSize=%ld, theme=%@", (long)fontSize, theme];
    [self appendLog:@"考点: registerDefaults 不会覆盖已存在的值，适合设置初始配置"];
    [self appendLog:@"考点: 默认值存储在内存中，不会写入磁盘 plist"];
    [self appendLog:@""];
}

#pragma mark - 6. App Group 共享
- (void)demo6_suiteName {
    [self appendTitle:@"6. App Group 共享数据（initWithSuiteName:）"];
    
    // 模拟 App Group 共享（需要先在 Capabilities 中开启）
    // NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.example.app"];
    // [shared setObject:@"sharedValue" forKey:@"sharedKey"];
    // [shared synchronize]; // App Group 场景建议手动同步
    
    [self appendLog:@"NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@\"group.com.xxx\"];"];
    [self appendLog:@"可用于主 App 与 Today Widget / Watch / Extension 共享配置"];
    [self appendLog:@"考点: 存储路径在 Group Containers 目录下，与普通沙盒隔离"];
    [self appendLog:@"考点: App Group 场景必须手动 synchronize"];
    [self appendLog:@"考点: 只适合少量配置数据，大量数据用文件或数据库"];
    [self appendLog:@""];
}

#pragma mark - 7. 线程安全
- (void)demo7_threadSafety {
    [self appendTitle:@"7. 线程安全"];
    
    [self appendLog:@"NSUserDefaults 内部使用自旋锁(spinlock)保护"];
    [self appendLog:@"单个 setObject:/objectForKey: 是线程安全的 ✅"];
    [self appendLog:@"但组合操作（先读后写）不是原子的 ❌"];
    [self appendLog:@"示例: if (count > 0) { count--; } 需要外部加锁"];
    [self appendLog:@"考点: 多线程场景下组合操作需自行加锁保护"];
    [self appendLog:@""];
}

#pragma mark - 8. 性能特点
- (void)demo8_performance {
    [self appendTitle:@"8. 性能特点"];
    
    [self appendLog:@"内存读取: 极快（ns级），直接从 NSDictionary 取"];
    [self appendLog:@"内存写入: 快，只写内存字典"];
    [self appendLog:@"磁盘写入: 慢（ms级），需序列化 + IO"];
    [self appendLog:@"首次读取: 较慢，需从磁盘加载 plist 到内存"];
    [self appendLog:@""];
    [self appendLog:@"考点: 不要存大量数据（每次启动加载整个 plist 到内存）"];
    [self appendLog:@"考点: 不要频繁写入（高频数据用数据库）"];
    [self appendLog:@"考点: 适合存用户偏好、配置开关、登录状态等少量数据"];
    [self appendLog:@""];
}

#pragma mark - 9. 存储位置
- (void)demo9_plistLocation {
    [self appendTitle:@"9. 存储位置"];
    
    // 沙盒路径
    NSString *homePath = NSHomeDirectory();
    NSString *prefPath = [homePath stringByAppendingPathComponent:@"Library/Preferences"];
    NSString *bundleID = [[NSBundle mainBundle] bundleIdentifier];
    NSString *plistPath = [prefPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", bundleID]];
    
    [self appendLog:@"沙盒路径: %@", homePath];
    [self appendLog:@"plist 路径: %@", plistPath];
    [self appendLog:@"考点: 存储在 Library/Preferences/<BundleID>.plist"];
    [self appendLog:@"考点: 底层基于 plist 文件，使用 mmap 映射到内存"];
    [self appendLog:@""];
}

#pragma mark - 10. KVO 监听
- (void)demo10_removeObserver {
    [self appendTitle:@"10. KVO 监听 NSUserDefaults 变化"];
    
    // 注册 KVO 监听
    [[NSUserDefaults standardUserDefaults] addObserver:self
                                           forKeyPath:@"userName"
                                              options:NSKeyValueObservingOptionNew
                                              context:nil];
    
    // 修改触发 KVO
    [[NSUserDefaults standardUserDefaults] setObject:@"王五" forKey:@"userName"];
    
    [self appendLog:@"考点: NSUserDefaults 支持 KVO 监听"];
    [self appendLog:@"考点: 注意在 dealloc 中移除观察者，否则 crash"];
    [self appendLog:@"考点: 也可用 NSNotificationName NSUserDefaultsDidChangeNotification"];
    [self appendLog:@""];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"userName"]) {
        NSString *newName = change[NSKeyValueChangeNewKey];
        [self appendLog:@"[KVO] userName 变更为: %@", newName];
        [self showLog];
    }
}

- (void)dealloc {
    @try {
        [[NSUserDefaults standardUserDefaults] removeObserver:self forKeyPath:@"userName"];
    } @catch (NSException *exception) {
        NSLog(@"移除 KVO 异常: %@", exception);
    }
}

#pragma mark - 面试总结
- (void)showLog {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.textView.text = self.log;
    });
}

#pragma mark - Helper

- (void)appendTitle:(NSString *)title {
    [self.log appendString:@"═══════════════════════════════════\n"];
    [self.log appendFormat:@"  %@\n", title];
    [self.log appendString:@"───────────────────────────────────\n"];
}

- (void)appendLog:(NSString *)format, ... {
    va_list args;
    va_start(args, format);
    NSString *msg = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    [self.log appendFormat:@"%@\n", msg];
}

@end

//
//  main.m — Block 面试考点全覆盖 Demo
//  直接运行即可看到控制台输出 ✅
//  每个考点都标注了对应的 Swift Closure 写法
//
//  ⚡ 使用方式：
//    终端：cd 到此目录 → clang -fobjc-arc -framework Foundation main.m -o demo && ./demo
//    Xcode：新建 macOS Command Line Tool 项目，替换 main.m 内容
//
//  📖 考点索引
//  考点1️⃣ Block 语法与类型定义
//  考点2️⃣ Block 三种类型 ⭐（Global / Stack / Malloc）
//  考点3️⃣ 变量捕获机制（值拷贝 / 指针拷贝 / __block）
//  考点4️⃣ __block 底层原理 ⭐（__Block_byref 结构体）
//  考点5️⃣ 循环引用 🔥🔥（最高频！weak-strong dance）
//  考点6️⃣ Block 内存管理
//  考点7️⃣ 应用场景（遍历 / 排序 / GCD / 回调）
//  考点8️⃣ 面试手写题实战
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

// ───────────────────────────────────────────────
// 考点 1️⃣ Block 语法与类型定义
// ───────────────────────────────────────────────
void exam_syntax(void) {
    printf("\n========== 考点1: Block 语法与类型定义 ==========\n");
    
    // 1. 最简形式
    void (^sayHi)(void) = ^{ printf("Hello Block!\n"); };
    sayHi();
    
    // 2. 带参数和返回值
    int (^add)(int, int) = ^(int a, int b) { return a + b; };
    printf("3 + 5 = %d\n", add(3, 5));
    
    // 3. typedef 定义（推荐，可读性好）
    typedef NSString * _Nullable (^StringFormatBlock)(NSString *, NSInteger);
    StringFormatBlock fmt = ^(NSString *pre, NSInteger n) {
        return [NSString stringWithFormat:@"%@-%ld", pre, (long)n];
    };
    printf("typedef: %s\n", fmt(@"Item", 99).UTF8String);
    
    // 4. 递归 Block（必须用 __block 引用自身）
    __block void (^fac)(NSInteger) = ^(NSInteger n) {
        printf("递归: %ld\n", (long)n);
        if (n > 0) fac(n - 1);
    };
    fac(3);
    // Swift: typealias Fmt = (String, Int) -> String

    printf("===== 考点1 结束 ===== \n\n");
}

// ───────────────────────────────────────────────
// 考点 2️⃣ Block 三种类型 ⭐
// ───────────────────────────────────────────────
void exam_block_types(void) {
    printf("\n========== 考点2: Block 三种类型 ==========\n");
    /*
     类型          存储位置       触发条件
     Global       全局数据区     不捕获自动变量
     Stack        栈            捕获变量（MRC）
     Malloc       堆            Stack Block copy
     */

    // 1. Global Block: 不捕获外部变量
    void (^globalB)(void) = ^{ printf("全局\n"); };
    printf("Global : %s\n", object_getClassName(globalB));

    // 2. ARC 下捕获变量 → 自动 copy 到堆 → Malloc
    int a = 10;
    void (^heapB)(void) = ^{ printf("堆 %d\n", a); };
    printf("ARC堆  : %s\n", object_getClassName(heapB));

    // 3. 用 __weak 阻止自动 copy → 栈 Block
    __weak void (^stackB)(void) = ^{ printf("栈 %d\n", a); };
    printf("Stack  : %s\n", object_getClassName(stackB));

    // 4. 栈 → 堆 copy
    void (^copiedB)(void) = [stackB copy];
    printf("Copy后 : %s\n", object_getClassName(copiedB));

    // Swift 对照：Closure 是引用类型，无此区分
    printf("===== 考点2 结束 ===== \n\n");
}

// ───────────────────────────────────────────────
// 考点 3️⃣ 变量捕获机制
// ───────────────────────────────────────────────
void exam_capture(void) {
    printf("\n========== 考点3: 变量捕获机制 ==========\n");
    /*
     局部变量  → 值拷贝，不能修改
     static   → 指针拷贝，可以修改
     全局变量  → 直接访问
     __block  → 结构体引用，可以修改
     对象      → 强引用拷贝（能改内容，不能重赋值）
     */

    // 1. 局部变量: 值拷贝
    int local = 42;
    void (^b1)(void) = ^{ printf("值拷贝: %d\n", local); };
    local = 100;
    b1(); // 42（拷贝时的值，不受外部影响）

    // 2. static: 指针拷贝
    static int sv = 50;
    void (^b2)(void) = ^{ sv++; printf("指针拷贝: %d\n", sv); };
    sv = 60;
    b2(); // 61（指向同一块内存）

    // 3. 全局变量: block 内外共享
    __block int gv = 100;    // 改为文件内也可访问
    void (^b3)(void) = ^{ gv++; printf("全局: %d\n", gv); };
    b3(); // 101

    printf("===== 考点3 结束 ===== \n\n");
}

// ───────────────────────────────────────────────
// 考点 4️⃣ __block 底层原理 ⭐
// ───────────────────────────────────────────────
void exam_block_keyword(void) {
    printf("\n========== 考点4: __block 原理 ==========\n");
    /*
     __block 本质：
     struct __Block_byref_count_0 {
         void *__isa;
         __Block_byref_count_0 *__forwarding; // 指向堆上的拷贝
         int __flags;
         int __size;
         int count;  // 原始变量
     };
     */

    // 多 block 共享同一个 __block 变量
    __block int c = 0;
    void (^b1)(void) = ^{ c++; };
    void (^b2)(void) = ^{ c++; };
    b1(); b2();
    printf("多Block共享: %d\n", c); // 2

    // 计数器工厂
    __block NSInteger cnt = 0;
    void (^counter)(void) = ^{ cnt++; printf("计数: %ld\n", (long)cnt); };
    counter(); counter(); counter();
    
    // Swift: var c = 0; let b = { c += 1 }
    printf("===== 考点4 结束 ===== \n\n");
}

// ───────────────────────────────────────────────
// 考点 5️⃣ 循环引用 🔥🔥（最高频）
// ───────────────────────────────────────────────
@interface TestObj : NSObject
@property (nonatomic, copy) void (^block)(void);
@end
@implementation TestObj
- (void)dealloc { printf("✅ TestObj dealloc\n"); }
@end

void exam_retain_cycle(void) {
    printf("\n========== 考点5: 循环引用 ==========\n");

    // ❌ 错误: 循环引用
    printf("❌ 循环引用场景: self -> block属性 -> self\n");
    @autoreleasepool {
        TestObj *obj = [[TestObj alloc] init];
        __weak TestObj *weakObj = obj;
        obj.block = ^{ printf("持有obj: %p\n", obj); }; // block 强持 obj
        obj = nil; // ❌ 不会释放（block 还持有）
        if (weakObj) printf("   → 未释放! 循环引用!\n");
        else         printf("   → 已释放\n");
        // 手动解除
    }

    // ✅ 正确: weak + strong dance
    printf("\n✅ weak-strong dance:\n");
    @autoreleasepool {
        TestObj *obj = [[TestObj alloc] init];
        __weak TestObj *wObj = obj;
        obj.block = ^{
            __strong TestObj *sObj = wObj;
            if (sObj) printf("安全使用: %p\n", sObj);
        };
        obj = nil; // ✅ 正常释放
    }
    
    printf("\n📌 面试速记:\n");
    printf("   __weak typeof(self) ws = self;\n");
    printf("   self.block = ^{\n");
    printf("       __strong typeof(ws) ss = ws;\n");
    printf("       if (!ss) return;\n");
    printf("       [ss doSomething];\n");
    printf("   };\n");
    printf("===== 考点5 结束 ===== \n\n");
}

// ───────────────────────────────────────────────
// 考点 6️⃣ Block 内存管理
// ───────────────────────────────────────────────
void exam_memory(void) {
    printf("\n========== 考点6: Block 内存管理 ==========\n");
    printf("属性声明:\n");
    printf("  MRC: @property (nonatomic, copy) void(^b)(void);\n");
    printf("  ARC: @property (nonatomic, strong/copy) void(^b)(void);\n\n");
    
    printf("原则:\n");
    printf("  1. 栈 Block 超出作用域会销毁（MRC 务必 copy）\n");
    printf("  2. Block 对捕获的 OC 对象做 retain（ARC = 强引用）\n");
    printf("  3. 不再需要时及时置 nil: self.block = nil;\n");
    printf("  4. 避免在 block 内捕获大对象\n");
    printf("===== 考点6 结束 ===== \n\n");
}

// ───────────────────────────────────────────────
// 考点 7️⃣ 应用场景
// ───────────────────────────────────────────────
void exam_applications(void) {
    printf("\n========== 考点7: 应用场景 ==========\n");
    printf("① 网络回调: completion(Data?, Error?) -> Void\n");
    
    // 遍历
    NSArray *arr = @[@"A", @"B", @"C"];
    [arr enumerateObjectsUsingBlock:^(id o, NSUInteger i, BOOL *s) {
        printf("遍历[%lu]: %s\n", (unsigned long)i, ((NSString *)o).UTF8String);
        if ([o isEqual:@"B"]) *s = YES;
    }];
    
    printf("③ 排序: sortUsingComparator:^NSComparisonResult\n");
    printf("④ GCD: dispatch_async(queue, ^{...})\n");
    printf("⑤ 动画: [UIView animateWithDuration:animations:]\n");
    printf("⑥ 传值: @property (copy) void(^callback)(id)\n");
    printf("===== 考点7 结束 ===== \n\n");
}

// ───────────────────────────────────────────────
// 考点 8️⃣ 面试手写题
// ───────────────────────────────────────────────
void exam_interview(void) {
    printf("\n========== 考点8: 面试手写题实战 ==========\n");
    
    printf("Q1: __weak + __strong 为什么需要两重？\n");
    printf("A: __weak 解决循环引用；__strong 防止执行期间被释放\n\n");
    
    printf("Q2: block 内直接使用 _ivar 会循环引用吗？\n");
    printf("A: 会！_ivar 等价于 self->ivar，隐式强引用 self\n\n");
    
    printf("Q3: block 属性为什么用 copy？\n");
    printf("A: MRC 下栈 block 会销毁；ARC 下虽然自动 copy 但保留 copy\n");
    printf("   是为了兼容和语义明确（确保 block 在堆上）\n\n");
    
    printf("Q4: __block 和 __weak 都能打破循环引用，哪个更好？\n");
    printf("A: __weak 更安全。__block 需要手动置 nil，容易遗忘\n\n");
    
    printf("Q5: Swift 闭包和 OC Block 的区别？\n");
    printf("A: 1) 闭包是引用类型（无栈/堆区分）\n");
    printf("   2) [weak self] vs __weak typeof(self) weakSelf\n");
    printf("   3) 尾随闭包语法糖 (Swift 独有)\n");
    printf("   4) @escaping 标记 vs block 属性 copy\n");
    printf("===== 考点8 结束 =====\n\n");
}

// ───────────────────────────────────────────────
// 主入口
// ───────────────────────────────────────────────
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        printf("═══════════════════════════════════════════\n");
        printf("   OC Block 面试考点全覆盖 Demo\n");
        printf("   共 8 个考点（每条标注 Swift 对照）\n");
        printf("═══════════════════════════════════════════\n\n");
        
        exam_syntax();
        exam_block_types();
        exam_capture();
        exam_block_keyword();
        exam_retain_cycle();
        exam_memory();
        exam_applications();
        exam_interview();
        
        printf("\n═══════════════════════════════════════════\n");
        printf("   ✅ 全部 Demo 运行完成\n");
        printf("═══════════════════════════════════════════\n");
    }
    return 0;
}

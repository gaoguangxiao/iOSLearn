//
//  ViewController.m
//  005-GCD-源发研读
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
    
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSLog(@"GCD函数分析");
        
    });

    dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    
}

/*
 
 DISPATCH_ALWAYS_INLINE
 static inline void
 _dispatch_sync_f_inline(dispatch_queue_t dq, void *ctxt,
         dispatch_function_t func, uintptr_t dc_flags)
 {
     if (likely(dq->dq_width == 1)) {//当dq_width为1，串行队列
         return _dispatch_barrier_sync_f(dq, ctxt, func, dc_flags);//栅栏函数
     }

     if (unlikely(dx_metatype(dq) != _DISPATCH_LANE_TYPE)) {
         DISPATCH_CLIENT_CRASH(0, "Queue type doesn't support dispatch_sync");
     }

     dispatch_lane_t dl = upcast(dq)._dl;
     // Global concurrent queues and queues bound to non-dispatch threads
     // always fall into the slow case, see DISPATCH_ROOT_QUEUE_STATE_INIT_VALUE
     if (unlikely(!_dispatch_queue_try_reserve_sync_width(dl))) {
         return _dispatch_sync_f_slow(dl, ctxt, func, 0, dl, dc_flags);
     }

     if (unlikely(dq->do_targetq->do_targetq)) {
         return _dispatch_sync_recurse(dl, ctxt, func, dc_flags);
     }
     _dispatch_introspection_sync_begin(dl);
     _dispatch_sync_invoke_and_complete(dl, ctxt, func DISPATCH_TRACE_ARG(
             _dispatch_trace_item_sync_push_pop(dq, ctxt, func, dc_flags)));
 }
 */


@end

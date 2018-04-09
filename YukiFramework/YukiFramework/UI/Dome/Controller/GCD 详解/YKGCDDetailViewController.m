//
//  YKGCDDetailViewController.m
//  YukiFramework
//
//  Created by 王宇 on 2018/4/4.
//  Copyright © 2018年 wy. All rights reserved.
//

#import "YKGCDDetailViewController.h"

@interface YKGCDDetailViewController (){
    dispatch_semaphore_t semapgoreLock;
}
/* 剩余火车票数 */
@property (nonatomic, assign) int ticketSurplusCount;
//@property (nonatomic, assign)
@end

@implementation YKGCDDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

-(void)setUI{
    self.title = @"GCD 详解";
    /* 任务+队列 相关方法  都满足先进先出的原则*/
    
//    同步执行 + 并发队列
//    [self syncConcurrent];
    
//    异步执行 + 并发队列
//    [self asyncConcurrent];
    
//    同步执行 + 串行队列
//    [self syncSerial];
    
//    异步执行 + 串行队列
//    [self asyncSerial];
    
//    同步执行 + 主队列(主线程调用)
//    [self syncMain];
    
////    同步执行 + 主队列(其他线程调用)
//    [NSThread detachNewThreadSelector:@selector(syncMain) toTarget:self withObject:nil];
    
//    异步执行 + 主队列
//    [self asyncMain];
    
//    线程间通信
//    [self communication];
    
//    栅栏方法
//    [self barrier];
    
//    延时方法
//    [self after];
    
//    执行一次方法
//    [self once];
    
//    快速迭代方法 (类似 for 循环)
//    [self apply];
    
//    队列组 dispatch_group_notify
//    [self groupNotify];
    
//    队列组 dispatch_group_wait
//    [self groupWait];
    
//    队列组 dispatch_group_enter、dispatch_group_leave
//    [self groupEnterAndLeave];
    
//    semaphore 线程同步
//    [self semaphore];
    
//    非线程安全 不使用 semaphore
//    [self initTicketStatusNotSave];
    
//     线程安全:使用 samephore 加锁
    [self initTicketStatusSave];
    
}

#pragma mark 任务+队列 相关方法
/*
 同步执行 + 并发队列
 特点: 在当前线程中执行任务，不会开启新线程，执行完一个任务，再执行下一个任务。
 */
-(void)syncConcurrent{
    DLog(@"currentThread----%@",[NSThread currentThread]);              //打印当前线程
    DLog(@"syncConcurrent-------begin");
    dispatch_queue_t queue = dispatch_queue_create("com.wangyu.cn.YukiFramework", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(queue, ^{
        // 任务1
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];                          // 模拟耗时操作
            DLog(@"1----%@",[NSThread currentThread]);                  //打印当前线程
        }
    });
    
    dispatch_sync(queue, ^{
        // 任务2
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];                          // 模拟耗时操作
            DLog(@"2----%@",[NSThread currentThread]);                  //打印当前线程
        }
    });
    
    dispatch_sync(queue, ^{
        // 任务3
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];                          // 模拟耗时操作
            DLog(@"3----%@",[NSThread currentThread]);                  //打印当前线程
        }
    });
    
    DLog(@"syncConcurrent-------end");
}

/*
 异步执行 + 并发队列
 特点:可以开启多个线程，任务交替（同时）执行。
 */
-(void)asyncConcurrent{
    DLog(@"currentThread----%@",[NSThread currentThread]);              //打印当前线程
    DLog(@"asyncConcurrent----begin");
    
    dispatch_queue_t queue = dispatch_queue_create("com.wangyu.cn.YukiFramework", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        //任务1
        for (int i = 0 ; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];                           // 模拟耗时操作
            DLog(@"1-----%@",[NSThread currentThread]);                  //打印当前线程
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i++) {
            //任务2
            [NSThread sleepForTimeInterval:2];                          // 模拟耗时操作
            DLog(@"2-----%@",[NSThread currentThread]);                  //打印当前线程
        }
    });
    
    dispatch_async(queue, ^{
       //任务3
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];                          // 模拟耗时操作
            DLog(@"3-----%@",[NSThread currentThread]);                //打印当前线程
        }
    });
    
    DLog(@"asyncConcurrent----end");
}

/*
 同步执行 + 串行队列
 特点: 不会开启新线程，在当前线程执行任务。任务是串行的，执行完一个任务，再执行下一个任务。
 */
-(void)syncSerial{
    DLog(@"currentThread----%@",[NSThread currentThread]);              //打印当前线程
    DLog(@"syncSerial----begin");
    
    dispatch_queue_t queue = dispatch_queue_create("com.wangyu.cn.YukiFramework", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(queue, ^{
       //任务1
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];                          // 模拟耗时操作
            DLog(@"1-----%@",[NSThread currentThread]);                 //打印当前线程
        }
    });
    
    dispatch_sync(queue, ^{
       //任务2
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];                          // 模拟耗时操作
            DLog(@"2-----%@",[NSThread currentThread]);                 //打印当前线程
        }
    });
    
    dispatch_sync(queue, ^{
        //任务3
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];                          // 模拟耗时操作
            DLog(@"3-----%@",[NSThread currentThread]);                 //打印当前线程
        }
    });
    
    DLog(@"syncSerial----end");
}

/*
 异步执行 + 串行队列
 特点: 会开启新的线程  但是因为任务是串行的 执行完一个任务 在执行下一个
 */
-(void)asyncSerial{
    DLog(@"currentThread----%@",[NSThread currentThread]);              //打印当前线程
    DLog(@"asyncSerial----begin");
    
    dispatch_queue_t queue = dispatch_queue_create("com.wangyu.cn.YukiFramework", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
       //任务1
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];                          // 模拟耗时操作
            DLog(@"1-----%@",[NSThread currentThread]);                 //打印当前线程
        }
    });
    
    dispatch_async(queue, ^{
        //任务2
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];                          // 模拟耗时操作
            DLog(@"2-----%@",[NSThread currentThread]);                 //打印当前线程
        }
    });
    
    dispatch_async(queue, ^{
        //任务3
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];                          // 模拟耗时操作
            DLog(@"3-----%@",[NSThread currentThread]);                 //打印当前线程
        }
    });
    
    DLog(@"asyncSerial----end");
}

/*
 同步执行 + 主队列
 特点(主线程调用): 互等卡主不执行, 都是大哥 互相礼让就卡死了
 特点(其他线程调用) : 不会开启新线程 执行完一个任务 在执行下一个任务
 */
-(void)syncMain{
    DLog(@"currentThread----%@",[NSThread currentThread]);              //打印当前线程
    DLog(@"syncMain----begin");
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_sync(queue, ^{
        //任务1
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];                          // 模拟耗时操作
            DLog(@"1--------%@",[NSThread currentThread]);              //打印当前线程
        }
    });
    
    dispatch_sync(queue, ^{
        //任务2
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];                          // 模拟耗时操作
            DLog(@"2--------%@",[NSThread currentThread]);              //打印当前线程
        }
    });
    
    dispatch_sync(queue, ^{
        //任务3
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];                          // 模拟耗时操作
            DLog(@"3--------%@",[NSThread currentThread]);              //打印当前线程
        }
    });
    
    DLog(@"syncMain----end");
    
}

/*
 异步执行 + 主队列
 特点: 只在主线程中执行任务 执行完一个人任务, 在执行下一个任务
 */
-(void)asyncMain{
    DLog(@"currentThread----%@",[NSThread currentThread]);              //打印当前线程
    DLog(@"asyncMain----begin");
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        //任务1
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];                          // 模拟耗时操作
            DLog(@"1------%@",[NSThread currentThread]);                //打印当前线程
        }
    });
    
    dispatch_async(queue, ^{
        //任务2
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];                          // 模拟耗时操作
            DLog(@"2------%@",[NSThread currentThread]);                //打印当前线程
        }
    });
    
    dispatch_async(queue, ^{
        //任务3
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];                          // 模拟耗时操作
            DLog(@"3------%@",[NSThread currentThread]);                //打印当前线程
        }
    });
    
    DLog(@"asyncMain----end");
}

#pragma mark 线程之间的通信
/*
 线程间通信
 */
-(void)communication{
    //获取全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //获取主队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
       //异步追加任务
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];                          // 模拟耗时操作
            DLog(@"1-----%@",[NSThread currentThread]);                 //打印当前线程
        }
        
        //回到主线程
        dispatch_async(mainQueue, ^{
            [NSThread sleepForTimeInterval:2];                           // 模拟耗时操作
            DLog(@"2------%@",[NSThread currentThread]);                 //打印当前线程
        });
    });
    
}


#pragma mark  GCD 其他方法
/*
 栅栏方法 dispatch_barrier_async
 特点 : 执行完前面的操作 在执行栅栏操作, 最后执行后面的(就像一个东西把他拦着一样)
 */
-(void)barrier{
    dispatch_queue_t queue = dispatch_queue_create("com.wangyu.cn.YukiFramework", DISPATCH_QUEUE_CONCURRENT);
    //异步才能体现出来
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i++) {
            //任务1
            [NSThread sleepForTimeInterval:2];                          // 模拟耗时操作
            DLog(@"1-----%@",[NSThread currentThread]);                 //打印当前线程
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i++) {
            //任务2
            [NSThread sleepForTimeInterval:2];                          // 模拟耗时操作
            DLog(@"2-----%@",[NSThread currentThread]);                 //打印当前线程
        }
    });
    
    dispatch_barrier_sync(queue, ^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            DLog(@"barrier------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i++) {
            //任务3
            [NSThread sleepForTimeInterval:2];                          // 模拟耗时操作
            DLog(@"3-----%@",[NSThread currentThread]);                 //打印当前线程
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i++) {
            //任务4
            [NSThread sleepForTimeInterval:2];                          // 模拟耗时操作
            DLog(@"4-----%@",[NSThread currentThread]);                 //打印当前线程
        }
    });
}
/*
 延时执行方法 dispatch_after
 */
-(void)after{
    DLog(@"currentThread----%@",[NSThread currentThread]);              //打印当前线程
    DLog(@"after----begin");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        DLog(@"after-----%@",[NSThread currentThread]);
    });
}

/*
 一次性代码执行(只会执行一次) dispatch_once (可以使用单例)
 */
-(void)once{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        DLog(@"222222");
    });
}

/*
 快速迭代方法 dispatch_apply (他的作用有点类似 for 循环) 在串行队列中  在异步或者并发队列中他的优势更能提现出来
 */
-(void)apply{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    DLog(@"apply-----begin");
    dispatch_apply(6, queue, ^(size_t index) {
        DLog(@"%ld-----%@",index,[NSThread currentThread]);
    });
    DLog(@"apply-----end");
}

#pragma mark  dispatch_group 队列组
/*
 队列组 dispatch_group_notify
 */
-(void)groupNotify{
    DLog(@"currentThread-----%@",[NSThread currentThread]);                 //打印当前线程
    DLog(@"groupNotify----begin");
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       //任务1
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];                          // 模拟耗时操作
            DLog(@"1-----%@",[NSThread currentThread]);                 //打印当前线程
        }
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //任务1
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];                          // 模拟耗时操作
            DLog(@"2-----%@",[NSThread currentThread]);                 //打印当前线程
        }
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 等前面的异步任务1、任务2都执行完毕后，回到主线程执行下边任务
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];                           // 模拟耗时操作
            DLog(@"3-----%@",[NSThread currentThread]);                   // 打印当前线程
        }
        DLog(@"group-----end");
    });
    
}

/*
队列组 dispatch_group_wait
 特点:等待上面的任务全部完成后悔往下继续执行 (其目的就是阻塞当前线程)
 */
-(void)groupWait{
    DLog(@"currentThread-----%@",[NSThread currentThread]);                 //打印当前线程
    DLog(@"groupWait----begin");
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //任务1
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];                          // 模拟耗时操作
            DLog(@"1-----%@",[NSThread currentThread]);                 //打印当前线程
        }
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //任务2
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];                          // 模拟耗时操作
            DLog(@"2-----%@",[NSThread currentThread]);                 //打印当前线程
        }
    });
    
    //等待上面的任务全部完成后悔往下继续执行 (其目的就是阻塞当前线程)
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    DLog(@"group-------end");
}

/*
 队列组 dispatch_group_enter、dispatch_group_leave
 */
-(void)groupEnterAndLeave{
    DLog(@"currentThread-----%@",[NSThread currentThread]);                 //打印当前线程
    DLog(@"groupEnterAndLeave----begin");
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_enter(group);
    
    dispatch_async(queue, ^{
        //任务1
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];                          // 模拟耗时操作
            DLog(@"1-----%@",[NSThread currentThread]);                 //打印当前线程
        }
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        //任务2
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];                          // 模拟耗时操作
            DLog(@"2-----%@",[NSThread currentThread]);                 //打印当前线程
        }
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
       //等到前面的异步操作执行完之后 回到主线程
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];                           // 模拟耗时操作
            DLog(@"3-----%@",[NSThread currentThread]);                   // 打印当前线程
        }
        DLog(@"group-----end");
    });
    

}

#pragma mark  线程同步
/*
 semaphore 线程同步
 */
-(void)semaphore{
    DLog(@"currentThread-----%@",[NSThread currentThread]);                 //打印当前线程
    DLog(@"semaphore----begin");
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    __block int number = 0;
    dispatch_async(queue, ^{
       //任务1
        [NSThread sleepForTimeInterval:2];                                  // 模拟耗时操作
        DLog(@"1---------%@",[NSThread currentThread]);                     // 打印当前线程
        
        number = 100;
        
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    DLog(@"semaphore---end,number = %zd",number);
//    semaphore---end,number = 100 打印的是这样的, 说明是一起出来的
}

#pragma mark  semaphore 线程安全
/*
 非线程安全 不使用 semaphore
 初始化火车票数量 卖票窗口(非线程安全) 并开始卖票
 */
-(void)initTicketStatusNotSave{
    DLog(@"currentThread-----%@",[NSThread currentThread]);                 //打印当前线程
    DLog(@"initTicketStatusNotSave----begin");
    
    self.ticketSurplusCount = 50;
    
    //queue1 代表窗口1售卖火车票
    dispatch_queue_t queue1 = dispatch_queue_create("com.wangyu.cn.YukiFramework", DISPATCH_QUEUE_SERIAL);
    //queue2 代表窗口2 售卖火车票
    dispatch_queue_t queue2 = dispatch_queue_create("com.wangyu.cn.YukiFramework", DISPATCH_QUEUE_SERIAL);
    @weakify(self)
    dispatch_async(queue1, ^{
        @strongify(self)
        [self saleTicketNotSafe];
    });
    
    dispatch_async(queue2, ^{
        @strongify(self)
        [self saleTicketNotSafe];
    });
    
}

/*
 售卖火车票(非线程安全)
 */
-(void)saleTicketNotSafe{
    while (true) {
        if (self.ticketSurplusCount > 0) {
            self.ticketSurplusCount -- ;
            DLog(@"%@",[NSString stringWithFormat:@"剩余票数:%d 窗口:%@",self.ticketSurplusCount,[NSThread currentThread]]);
            [NSThread sleepForTimeInterval:0.2];
        }else{
            DLog(@"所有火车票均已售完");
            break;
        }
    }
}

/*
 线程安全:使用 samephore 加锁
 初始化火车票数量、卖票窗口(线程安全)、并开始卖票
 */
-(void)initTicketStatusSave{
    DLog(@"currentThread-----%@",[NSThread currentThread]);                 //打印当前线程
    DLog(@"initTicketStatusSave----begin");
    
    self.ticketSurplusCount = 50;
    
    semapgoreLock = dispatch_semaphore_create(1);
    
    //queue1 代表窗口1售卖火车票
    dispatch_queue_t queue1 = dispatch_queue_create("com.wangyu.cn.YukiFramework", DISPATCH_QUEUE_SERIAL);
    //queue2 代表窗口2 售卖火车票
    dispatch_queue_t queue2 = dispatch_queue_create("com.wangyu.cn.YukiFramework", DISPATCH_QUEUE_SERIAL);
    
    @weakify(self)
    dispatch_async(queue1, ^{
        @strongify(self)
        [self saleTicketSafe];
    });
    
    dispatch_async(queue2, ^{
        @strongify(self)
        [self saleTicketSafe];
    });
}

/*
 售卖火车票(线程安全)
 */
-(void)saleTicketSafe{
    while (1) {
        //相等于加锁
        dispatch_semaphore_wait(semapgoreLock, DISPATCH_TIME_FOREVER);
        if ( self.ticketSurplusCount > 0) { //如果有就继续卖
            self.ticketSurplusCount -- ;
            DLog(@"%@",[NSString stringWithFormat:@"剩余票数:%d 窗口:%@",self.ticketSurplusCount,[NSThread currentThread]]);
            [NSThread sleepForTimeInterval:0.2];
        }else{
            DLog(@"所有火车票卖完");
            //相当于解锁
            dispatch_semaphore_signal(semapgoreLock);
            break;
        }
        
        //相当于解锁
        dispatch_semaphore_signal(semapgoreLock);
    }
}

@end

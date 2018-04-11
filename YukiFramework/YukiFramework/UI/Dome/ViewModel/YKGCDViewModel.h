//
//  YKGCDViewModel.h
//  YukiFramework
//
//  Created by 王宇 on 2018/4/11.
//  Copyright © 2018年 wy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^callBackBlock)(void);
@interface YKGCDViewModel : NSObject

NS_ASSUME_NONNULL_BEGIN
/**
 数据源
 */
@property (nonatomic, strong) NSArray *dataArr,*detailArr;

/**
 返回
 */
@property (nonatomic, copy) callBackBlock successBlock;

/* 剩余火车票数 */
@property (nonatomic, assign) int ticketSurplusCount;


/**
 得到数据
 */
-(void)getData:(void(^)(void))success failureBlock:(void(^)(void))failure;

#pragma mark 任务+队列 相关方

/**
  同步执行 + 并发队列
 */
-(void)syncConcurrent;

/**
  异步执行 + 并发队列
 */
-(void)asyncConcurrent;

/**
  同步执行 + 串行队列
 */
-(void)syncSerial;

/**
 异步执行 + 串行队列
 */
-(void)asyncSerial;

/**
 同步执行 + 主队列(在主队列中)
 */
-(void)syncMain;

/**
 同步执行 + 主队列(在其他队列中)
 */
-(void)otherSync;

/**
 异步执行 + 主队列
 */
-(void)asyncMain;

#pragma mark 线程之间的通信

/**
线程间通信
 */
-(void)communication;

#pragma mark  GCD 其他方法

/**
 栅栏方法 dispatch_barrier_async
 */
-(void)barrier;

/**
 延时执行方法 dispatch_after
 */
-(void)after;

/**
  一次性代码执行(只会执行一次) dispatch_once (可以使用单例)
 */
-(void)once;

/**
 快速迭代方法 dispatch_apply (他的作用有点类似 for 循环) 在串行队列中  在异步或者并发队列中他的优势更能提现出来
 */
-(void)apply;

#pragma mark  dispatch_group 队列组

/**
  队列组 dispatch_group_notify
 */
-(void)groupNotify;

/**
 队列组 dispatch_group_wait
 */
-(void)groupWait;

/**
 队列组 dispatch_group_enter、dispatch_group_leave
 */
-(void)groupEnterAndLeave;

#pragma mark  线程同步

/**
  semaphore 线程同步
 */
-(void)semaphore;

#pragma mark  semaphore 线程安全

/**
 非线程安全 不使用 semaphore
 */
-(void)initTicketStatusNotSave;

/**
 线程安全:使用 samephore 加锁
 */
-(void)initTicketStatusSave;

NS_ASSUME_NONNULL_END

@end

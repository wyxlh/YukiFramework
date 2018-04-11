//
//  YKGCDUIService.m
//  YukiFramework
//
//  Created by 王宇 on 2018/4/11.
//  Copyright © 2018年 wy. All rights reserved.
//

#import "YKGCDUIService.h"
#import "YKGCDTableViewCell.h"
@implementation YKGCDUIService

#pragma mark -UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YKGCDTableViewCell *cell                = [tableView dequeueReusableCellWithIdentifier:@"YKGCDTableViewCell" forIndexPath:indexPath];
    cell.title.text                         = self.viewModel.dataArr[indexPath.row];
    cell.detailtIT.text                     = self.viewModel.detailArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            //同步执行 + 并发队列
            [self.viewModel syncConcurrent];
        }
            break;
        case 1:
        {
            //异步执行 + 并发队列
            [self.viewModel asyncConcurrent];
        }
            break;
        case 2:
        {
            //同步执行 + 串行队列
            [self.viewModel syncSerial];
        }
            break;
        case 3:
        {
            //异步执行 + 串行队列
            [self.viewModel asyncSerial];
        }
            break;
        case 4:
        {
            //同步执行 + 主队列(主线程调用)
            [self.viewModel syncMain];
        }
            break;
        case 5:
        {
            //同步执行 + 主队列(其他线程调用)
            [self.viewModel otherSync];
        }
            break;
        case 6:
        {
            //异步执行 + 主队列
            [self.viewModel asyncMain];
        }
            break;
        case 7:
        {
            //线程间通信
            [self.viewModel communication];
        }
            break;
        case 8:
        {
            //栅栏方法
            [self.viewModel barrier];
        }
            break;
        case 9:
        {
            //延时方法
            [self.viewModel after];
        }
            break;
        case 10:
        {
            //执行一次方法
            [self.viewModel once];
        }
            break;
        case 11:
        {
            //快速迭代方法 (类似 for 循环)
            [self.viewModel apply];
        }
            break;
        case 12:
        {
            //队列组 dispatch_group_notify 不会阻塞当前线程
            [self.viewModel groupNotify];
        }
            break;
        case 13:
        {
            //队列组 dispatch_group_wait 会阻塞当前线程
            [self.viewModel groupWait];
        }
            break;
        case 14:
        {
            //队列组 dispatch_group_enter、dispatch_group_leave
            [self.viewModel groupEnterAndLeave];
        }
            break;
        case 15:
        {
            //semaphore 线程同步
            [self.viewModel semaphore];
        }
            break;
        case 16:
        {
            //非线程安全 不使用 semaphore
            [self.viewModel initTicketStatusNotSave];
        }
            break;
        case 17:
        {
            //线程安全:使用 samephore 加锁
            [self.viewModel initTicketStatusSave];
        }
            break;

        default:
            break;
    }
}
@end

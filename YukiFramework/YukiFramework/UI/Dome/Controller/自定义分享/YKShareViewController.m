//
//  YKShareViewController.m
//  YukiFramework
//
//  Created by 王宇 on 2018/6/1.
//  Copyright © 2018年 wy. All rights reserved.
//

#import "YKShareViewController.h"
#import "YFShareView.h"
@interface YKShareViewController ()
@property (nonatomic, strong) NSThread *thread;
@end

@implementation YKShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title                      = @"自定义分享";
    [self addRightTitleBtn:@"RunLoop"];
    
    self.thread                     = [[NSThread alloc]initWithTarget:self selector:@selector(run1) object:self];
    [self.thread start];
    
}

#pragma mark  线程常驻
- (void)run1{
    // 这里写任务
    DLog(@"----run1-----");
    
    // 添加下边两句代码，就可以开启RunLoop，之后self.thread就变成了常驻线程，可随时添加任务，并交于RunLoop处理
    [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
    
    // 测试是否开启了RunLoop，如果开启RunLoop，则来不了这里，因为RunLoop开启了循环。
    DLog(@"未开启RunLoop");
}

- (void)rightTitleButtonClick:(UIButton *)sender{
    // 利用performSelector，在self.thread的线程中调用run2方法执行任务
    [self performSelector:@selector(run2) onThread:self.thread withObject:nil waitUntilDone:NO];
}

- (void)run2{
    DLog(@"----run2-----");
}

#pragma mark 分享
- (IBAction)clickShare:(id)sender {
    UIWindow *win                   = [UIApplication sharedApplication].keyWindow;
    YFShareView *shareView          = [[YFShareView alloc] initWithFrame:CGRectZero];
    shareView.shareContent          = @"免费找车，实时竞价，飞一般的发货感受！";
    shareView.shareImage            = @"shareIcon";
    shareView.shareTitle            = @"做最省心的货主，就上乾坤货主APP！";
    shareView.superVC               = self;
    shareView.shareUrl              = @"http://app.yuanfusc.com/downapp/";
    [win addSubview:shareView];
}







@end

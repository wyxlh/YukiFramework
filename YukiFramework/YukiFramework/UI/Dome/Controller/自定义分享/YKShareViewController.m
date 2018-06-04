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

@end

@implementation YKShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title                      = @"自定义分享";
}

- (IBAction)clickShare:(id)sender {
    UIWindow *win = [UIApplication sharedApplication].keyWindow;
    YFShareView *shareView = [[YFShareView alloc] initWithFrame:CGRectZero];
    shareView.shareContent = @"免费找车，实时竞价，飞一般的发货感受！";
    shareView.shareImage = @"shareIcon";
    shareView.shareTitle = @"做最省心的货主，就上乾坤货主APP！";
    shareView.superVC = self;
    shareView.shareUrl = @"http://app.yuanfusc.com/downapp/";
    [win addSubview:shareView];
}



@end

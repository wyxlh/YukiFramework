//
//  YKDemoListViewModel.m
//  YukiFramework
//
//  Created by 王宇 on 2018/6/6.
//  Copyright © 2018年 wy. All rights reserved.
//

#import "YKDemoListViewModel.h"
#import "YukiCollectionSuspensionViewController.h"
#import "YukiShoppingCartViewController.h"
#import "YukiShowPhotoWebViewController.h"
#import "YukiTitleScorllViewController.h"
#import "WKAttributdeLblViewController.h"
#import "YukiStaticLibraryViewController.h"
#import "YKLiveCommentViewController.h"
#import "YKGCDDetailViewController.h"
#import "YKVoicePlaybackViewController.h"
#import "YKPlayTypeViewController.h"
#import "YKShareViewController.h"
#import "YKShortVideoViewController.h"
@implementation YKDemoListViewModel

- (void)setUIWithSuccess:(void(^)(void))success{
    self.dataArr = @[@[@"CollectionView头部悬浮",@"加载网页的进度条",@"TitleScorllView",@"自定义分享"],
                    @[@"TableView动画",@"富文本设置",@"制作静态庫.a文件",@"制作静态库FrameWork",@"仿直播间评论效果",@"仿短视频翻页效果"],
                    @[@"GCD详解",@"语音播放文字内容"],
                    @[@"支付方式"]];
    if (success) {
        success();
    }
}

- (void)jumpVCWithSelectSection:(NSInteger)section SelectIndex:(NSInteger)index{
    if (section == 0) {
        if (index == 0) {
            //CollectionView头部悬浮
            YukiCollectionSuspensionViewController *suspen = [YukiCollectionSuspensionViewController new];
            !self.jumpBlock ? : self.jumpBlock (suspen);
        }else if (index == 1){
            //加载网页的进度条
            YukiShowPhotoWebViewController *web            = [YukiShowPhotoWebViewController new];
            web.title                                      = @"网页进度条";
            web.urlString                                  = @"https://www.baidu.com";
            web.progressColor                              = NavColor;
            !self.jumpBlock ? : self.jumpBlock (web);
        }else if (index == 2){
            //TitleScorllView
            YukiTitleScorllViewController *titleScorll     = [YukiTitleScorllViewController new];
            !self.jumpBlock ? : self.jumpBlock (titleScorll);
        }else{
            YKShareViewController *share                   = [YKShareViewController new];
            !self.jumpBlock ? : self.jumpBlock (share);
        }
    }else if (section == 1){
        if (index == 0) {
            //TableView动画
            YukiShoppingCartViewController *shopping       = [YukiShoppingCartViewController new];
            !self.jumpBlock ? : self.jumpBlock (shopping);
        }else if (index == 1){
            //富文本
            WKAttributdeLblViewController *att             = [WKAttributdeLblViewController new];
            !self.jumpBlock ? : self.jumpBlock (att);
        }else if (index == 2){
            //制作静态庫.a
            YukiStaticLibraryViewController *library       = [YukiStaticLibraryViewController new];
            !self.jumpBlock ? : self.jumpBlock (library);
        }else if (index == 3){
            //制作静态庫FrameWork
            YukiWebViewController *web                     = [YukiWebViewController new];
            web.title                                      = @"制作FrameWork";
            web.urlString                                  = @"https://www.jianshu.com/p/1523400f8613";
            !self.jumpBlock ? : self.jumpBlock (web);
        }else if (index == 4){
            //仿直播间评论效果
            YKLiveCommentViewController *live              = [YKLiveCommentViewController new];
            !self.jumpBlock ? : self.jumpBlock (live);
        }else if (index == 5){
            YKShortVideoViewController *shortVideo         = [YKShortVideoViewController new];
            !self.jumpBlock ? : self.jumpBlock (shortVideo);
        }
    }else if (section == 2){
        if (index == 0) {
            //GCD 详解
            YKGCDDetailViewController *gcd                 = [YKGCDDetailViewController new];
            !self.jumpBlock ? : self.jumpBlock (gcd);
        }else if (index == 1){
            //文字合成语音播放
            YKVoicePlaybackViewController *voice           = [YKVoicePlaybackViewController new];
            !self.jumpBlock ? : self.jumpBlock (voice);
        }
    }else if (section == 3){
        if (index == 0) {
            //支付方式
            YKPlayTypeViewController *payType              = [YKPlayTypeViewController new];
            !self.jumpBlock ? : self.jumpBlock (payType);
        }
    }
}

@end

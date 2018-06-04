//
//  YFShareView.m
//  YFKit
//
//  Created by 王宇 on 2018/5/23.
//  Copyright © 2018年 wy. All rights reserved.
//

#import "YFShareView.h"
#import "YFShareButton.h"
#import <UMShare/UMShare.h>
#import <UMSocialWechatHandler.h>
#import <UMCommon/UMCommon.h>
@interface YFShareView()
/**
 图片
 */
@property (nonatomic, strong, nullable) NSArray *imgArr;
/**
title
 */
@property (nonatomic, strong, nullable) NSArray *titleArr;

@property (nonatomic,weak) UIView *tipView;
@property (nonatomic,weak) UIView *cover;

@end

@implementation YFShareView

-(instancetype)initWithFrame:(CGRect)frame{
   self = [super initWithFrame:frame];
    if (self) {
        // 创建一个阴影
        UIWindow *win                           = [UIApplication sharedApplication].keyWindow;
        UIView *cover                           = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        cover.backgroundColor                   = [UIColor blackColor];
        self.cover                              = cover;
        [cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCancel)]];
        cover.tag                               = 100;
        cover.alpha                             = 0;
        [win addSubview:cover];
        
        // 创建一个提示框
        CGFloat tipX                            = 0;
        CGFloat tipW                            = cover.frame.size.width - 2*tipX;
        CGFloat tipH                            = 200;
        
        UIView *tipViews                        = [[UIView alloc] initWithFrame:CGRectMake(tipX, ScreenHeight, tipW, tipH)];
        tipViews.backgroundColor                = [UIColor whiteColor];
        [win addSubview:tipViews];
        self.tipView = tipViews;
        
        [UIView animateWithDuration:0.25 animations:^{
            CGFloat tipY                        = (ScreenHeight-tipH);
            cover.alpha                         = 0.5;
            tipViews.frame                      = CGRectMake(tipX, tipY, tipW, tipH);
        } completion:^(BOOL finished) {
            
        }];

        if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
            self.imgArr                         = @[@"Wechatt",@"wxFriends"];
            self.titleArr                       = @[@"微信好友",@"朋友圈"];
        }
        
        for (int i = 0; i < self.imgArr.count; i ++) {
            __weak YFShareButton *shareBtn             = [[[NSBundle mainBundle] loadNibNamed:@"YFShareButton" owner:nil options:nil] firstObject];
            if (i == 0) {
                shareBtn.frame                  = CGRectMake(ScreenWidth/4-50, 20, 80, 100);
            }else{
                shareBtn.frame                  = CGRectMake(ScreenWidth/4*3-50, 20, 80, 100);
            }
            @weakify(self)
            shareBtn.clickShareBtnBlock         = ^{
                @strongify(self)
                [self clickShareBtn:shareBtn];
            };
            shareBtn.title.text                 = self.titleArr[i];
            shareBtn.imgView.image              = [UIImage imageNamed:self.imgArr[i]];
            [tipViews addSubview:shareBtn];
        }
        
        UIView *line                            = [[UIView alloc]initWithFrame:CGRectMake(0, tipViews.frame.size.height-50, ScreenWidth, 1)];
        line.backgroundColor                    = [UIColor groupTableViewBackgroundColor];
        [tipViews addSubview:line];
        CGFloat btnW                            = 80;
        UIButton *cancelBtn                     = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame                         = CGRectMake((tipViews.frame.size.width-btnW)*0.5, tipViews.frame.size.height - 49, btnW, 49);
        [cancelBtn setTitleColor:UIColorFromRGB(0x636465) forState:UIControlStateNormal];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        cancelBtn.titleLabel.font               = [UIFont systemFontOfSize:16];
        [cancelBtn addTarget:self action:@selector(clickCancel) forControlEvents:UIControlEventTouchUpInside];
        [tipViews addSubview:cancelBtn];
        
    }
    return self;
}

- (void)clickCancel
{
    [UIView animateWithDuration:0.25 animations:^{
        self.tipView.mj_y = ScreenHeight;
        self.cover.alpha = 0;
    } completion:^(BOOL finished) {
        [self.tipView removeFromSuperview];
        [self.cover removeFromSuperview];
        self.cover = nil;
        self.tipView = nil;
    }];
}

-(void)clickShareBtn:(YFShareButton *)btn{
    DLog(@"%@",btn.title.text);
    [self clickCancel];

    if ([btn.title.text isEqualToString:@"微信好友"]) {
        [self shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
    }else{
        [self shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine];
    }
    
}

//网页分享
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UIImage *thumbURL = [UIImage imageNamed:self.shareImage] ;
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.shareTitle descr:self.shareContent thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = self.shareUrl;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
#ifdef UM_Swift
    [UMSocialSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self.superVC completion:^(UMSocialShareResponse * data, NSError * error) {
#else
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self.superVC completion:^(id data, NSError *error) {
#endif
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
//                   [ YFToast showMessage:@"分享成功" inView:[[[YFKeyWindow shareInstance] getCurrentVC] view]];
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }

        }];
    }
     
- (void)setPinterstInfo:(UMSocialMessageObject *)messageObj
{
    messageObj.moreInfo = @{@"source_url": @"http://www.umeng.com",
                            @"app_name": @"U-Share",
                            @"suggested_board_name": @"UShareProduce",
                            @"description": @"U-Share: best social bridge"};
}




@end

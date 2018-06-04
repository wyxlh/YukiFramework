//
//  YFShareView.h
//  YFKit
//
//  Created by 王宇 on 2018/5/23.
//  Copyright © 2018年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YukiBaseViewController.h"

@interface YFShareView : UIView
NS_ASSUME_NONNULL_BEGIN

/**
 title
 */
@property (nonatomic, copy) NSString *shareTitle;

/**
 分享内容
 */
@property (nonatomic, copy) NSString *shareContent;

/**
 分享图片
 */
@property (nonatomic, copy) NSString *shareImage;

/**
 分享链接
 */
@property (nonatomic, copy) NSString *shareUrl;

@property (nonatomic, strong) YukiBaseViewController *superVC;
NS_ASSUME_NONNULL_END
@end

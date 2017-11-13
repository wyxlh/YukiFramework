//
//  YukiBaseViewController.h
//  YukiFramework
//
//  Created by 王宇 on 2017/11/9.
//  Copyright © 2017年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YukiHelp.h"
#import "WKNavigationController.h"
#import "WKTabbarController.h"
#import "AppDelegate.h"
@interface YukiBaseViewController : UIViewController
NS_ASSUME_NONNULL_BEGIN
/**
 导航栏
 */
@property (nonatomic, strong) WKNavigationController *navbar;

/**
 工具栏
 */
@property (nonatomic, strong) WKTabbarController *tabbarVC;

/**
 返回按钮
 */
@property (nonatomic, strong) UIButton *backItem;

/**
 左边的按钮 传Title的时候
 */
@property (nonatomic, strong) UIButton *leftTitleBtn;

/**
用的时候需要重写此方法

 @param leftTitleBtnName 填你需要的文字
 */
-(void)addLeftTitleBtn:(NSString *)leftTitleBtnName;

/**
  左边的按钮 传图片名的时候
 */
@property (nonatomic, strong) UIButton *leftImageBtn;

/**
 用的时候需要重写此方法

 @param leftImageBtnName 填你需要的图片名
 */
-(void)addLeftImageBtn:(NSString *)leftImageBtnName;

/**
 右边的按钮 传 Title的时候
 */
@property (nonatomic,strong) UIButton *rightTitleBtn;

/**
 用的时候需要重写此方法

 @param rightTitleBtnName 填你需要的文字
 */
-(void)addRightTitleBtn:(NSString *)rightTitleBtnName;

/**
  右边的按钮 传 图片名字的时候
 */
@property (nonatomic,strong) UIButton *rightImageBtn;

/**
  用的时候需要重写此方法

 @param rightImageBtnName 填你需要的图片名
 */
-(void)addRightImageBtn:(NSString *)rightImageBtnName;

#pragma mark 几种按钮的点击方法

-(void)leftTitleButtonClick:(UIButton *)sender;

-(void)leftImageButtonClick:(UIButton *)sender;

-(void)rightTitleButtonClick:(UIButton *)sender;

-(void)rightImageButtonClick:(UIButton *)sender;

/**
 *  返回
 */
- (void)goBack;

/**
 选的那个 tabbar

 @param index 选中第几个
 */
-(void)selectTabbarIndex:(NSInteger )index;

/**
 *  指定哪一个Tabbar上面有一个小红点。为0 就不显示了
 *
 *  @param badgeValue 数量
 *  @param index      index
 */
-(void)selectBadgeValue:(NSInteger)badgeValue toIndex:(NSInteger)index;
NS_ASSUME_NONNULL_END
@end

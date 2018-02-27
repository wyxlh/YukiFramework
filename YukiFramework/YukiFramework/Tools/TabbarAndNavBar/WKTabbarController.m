//
//  WKTabbarController.m
//  WKKit
//
//  Created by 王宇 on 16/9/13.
//  Copyright © 2016年 王宇. All rights reserved.
//
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#import "WKTabbarController.h"
#import "YukiHomeViewController.h"
#import "YukuClassViewController.h"
#import "YukiShoppingCartViewController.h"
#import "YukiUserCenterViewController.h"
#import "WKNavigationController.h"
@interface WKTabbarController ()<UITabBarControllerDelegate>

@end

@implementation WKTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor=UIColorFromRGB(0xE26B1C);
    [self addChildViewControllers];
}

- (void) addChildViewControllers {
    
    YukiHomeViewController *homeVC                    = [[YukiHomeViewController alloc] init];
    
    YukuClassViewController *upwardVarietyVC         = [[YukuClassViewController alloc] init];
    
    YukiShoppingCartViewController *varietyVC       = [[YukiShoppingCartViewController alloc] init];
    
    YukiUserCenterViewController *mailVC              = [[YukiUserCenterViewController alloc] init];
    
    
    
    [self addChildVC:homeVC normalImageName:@"foot_home" selectedImageName:@"foot_homecurrent" title:@"首页"];
    
    [self addChildVC:upwardVarietyVC normalImageName:@"foot_star" selectedImageName:@"foot_star_current" title:@"上综艺"];
    
    [self addChildVC:varietyVC normalImageName:@"foot_variety" selectedImageName:@"foot_variety_current" title:@"追综艺"];
    
    [self addChildVC:mailVC normalImageName:@"foot_shop" selectedImageName:@"foot_shop_current" title:@"买爆款"];
    
    
    
}

+ (void)initialize {
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0x888888),NSFontAttributeName : [UIFont systemFontOfSize:11.0f]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0xE26B1C),NSFontAttributeName : [UIFont systemFontOfSize:11.0f]} forState:UIControlStateSelected];
    
}

/**
 添加子控制器
 
 @param vc                子控制器
 @param normalImageName   普通状态下图片
 @param selectedImageName 选中图片
 */
- (void)addChildVC: (UIViewController *)vc normalImageName: (NSString *)normalImageName selectedImageName:(NSString *)selectedImageName  title:(NSString *)title {
    
    WKNavigationController *nav             = [[WKNavigationController alloc] initWithRootViewController:vc];
    
    nav.tabBarItem                          = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:normalImageName] selectedImage:[UIImage imageNamed:selectedImageName]];
    nav.tabBarItem.titlePositionAdjustment  = UIOffsetMake(0.0f, -3.0f);
    [self addChildViewController:nav];
    
}

/**
 *  指定选中这个Tabbar
 *
 */
-(void)appointTabbarIndex:(NSInteger)index{
    
    NSInteger number = self.viewControllers.count;
    if (index >= number|| index<0) {
    }else{
        [self setSelectedIndex:index];
        //        UIViewController *vc    = self.viewControllers[index];
        //        _tb.postImageBtn.hidden = ![self isPostMessageVC:vc];
    }
    
}

/**
 *  指定哪一个Tabbar上面有一个小红点。为0 就不显示了
 *
 *  @param badgeValue 数量
 *  @param index      index
 */
-(void)appointbadgeValue:(NSInteger)badgeValue toIndex:(NSInteger)index{
    
    
    if (badgeValue!=0) {
        NSInteger number = self.viewControllers.count;
        if (index<number) {
            UIViewController *VC = [self.viewControllers objectAtIndex:index];
            VC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",(long)badgeValue];
        }
    } else {
        NSInteger number = self.viewControllers.count;
        if (index<number) {
            UIViewController *VC = [self.viewControllers objectAtIndex:index];
            VC.tabBarItem.badgeValue = nil;
        }
    }
}


@end

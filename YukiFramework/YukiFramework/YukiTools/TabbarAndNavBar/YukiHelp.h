//
//  YukiHelp.h
//  YukiFramework
//
//  Created by 王宇 on 2017/11/9.
//  Copyright © 2017年 wy. All rights reserved.
//

#ifndef YukiHelp_h
#define YukiHelp_h
//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//获取设备的物理宽度
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
// Tabbar 高度
#define TabbarHeight (ScreenHeight > 736 ? 83.0f : 49.0f)

//自定义颜色
#define CustomColor(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// 设置view的圆角和边框
#define SKViewsBorder(View,radius,width,color)\
\
[View.layer setCornerRadius:(radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(width)];\
[View.layer setBorderColor:[color CGColor]];

#pragma mark ---------------------------------LOG--------------------------------------------------
//打印Log
#ifdef DEBUG
#define DLog( s, ... )                          NSLog( @"<%@:(%d)> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DLog( s, ... )
#endif

#pragma mark ------------------------------Bolck Self--------------------------------------------------
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define HOST_URL  @"http://v.juhe.cn"
#endif /* YukiHelp_h */

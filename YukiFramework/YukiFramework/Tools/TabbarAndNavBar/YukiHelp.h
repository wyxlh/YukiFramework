//
//  YukiHelp.h
//  YukiFramework
//
//  Created by 王宇 on 2017/11/9.
//  Copyright © 2017年 wy. All rights reserved.
//

#ifndef YukiHelp_h
#define YukiHelp_h

// 银联支付的环境   00正式01测试
#define YinLianCeShi  @"01"
#define YinLianZhengShi  @"00"

//微信的Key
//#define WXAppId          @"wx692ec46fc9acc2b0"
//#define WXappSecret      @"833b9e6d48f9bb209cec4b2b11aab100"
//#define WeiXinPartnerId  @"1481778242"
//#define WeiXinPartnerKey @"wx692ec46fc9acc2b012345678987654"
#define WXAppId            @"wx55cdec5c462c13af"
#define WXappSecret        @"0d47df340f75baf8950db58bb39afa58"
#define WeiXinPartnerId    @"1503466011"
#define WeiXinPartnerKey   @"12AsdAsd88888273hashdjdhASHDSHDD"

//友盟APPKey
#define UmengAppKey   @"5b04c2bdf43e4858b8000157"
#define UmengURL      @"http://www.umeng.com/social"

//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//获取设备的物理宽度
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
// Tabbar 高度
#define TabbarHeight (ScreenHeight == 812.0 ? 83.0f : 49.0f)

//导航栏高度
#define NavHeight (ScreenHeight == 812.0 ? 88.0f : 64.0f)

//自定义颜色
#define CustomColor(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//主题色
#define NavColor UIColorFromRGB(0xE26B1C)

#define  SKUserDefaults       [NSUserDefaults  standardUserDefaults]

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
//#define HOST_URL  @"http://192.168.1.123:8080/tmsapp"
#endif /* YukiHelp_h */

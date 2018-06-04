//
//  AppDelegate.m
//  YukiFramework
//
//  Created by 王宇 on 2017/11/9.
//  Copyright © 2017年 wy. All rights reserved.
//

#import "AppDelegate.h"
#import <AlipaySDK/AlipaySDK.h>
/**微信*/
#import "WXApi.h"
#import "WXApiObject.h"
/**银联*/
#import "UPPaymentControl.h"
#import "YKAlipayTool.h"
#import <UMShare/UMShare.h>
#import <UMSocialWechatHandler.h>
#import <UMCommon/UMCommon.h>
@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.S
    //微信ID支付
    [WXApi registerApp:WXAppId enableMTA:YES];
    [self configureUmengKeyManger];
    [self createTabbar];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [self applicationOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [self applicationOpenURL:url];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary*)options
{
    return [self applicationOpenURL:url];
}

- (BOOL)applicationOpenURL:(NSURL *)url
{
    if ([[url absoluteString] containsString:@"safepay"]) {
        //支付宝
        [self configureForAliPay:url];
        return NO;
    }else if([[url absoluteString] rangeOfString:[NSString stringWithFormat:@"%@://pay",WXAppId]].location == 0){
        //微信支付
        return [WXApi handleOpenURL:url delegate:self];
    }else if([[url absoluteString] containsString:@"uppayresult"]){
        [self configureForYinLian:url];
        return NO;
    }
    return [[UMSocialManager defaultManager] handleOpenURL:url];
}

#pragma mark - 注册友盟分享
-(void)configureUmengKeyManger{
    
    [UMConfigure initWithAppkey:UmengAppKey channel:@"App Store"]; // required
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAppId appSecret:WXappSecret redirectURL:nil];
    
}

#pragma mark - 支付宝支付成功后的回调
- (void)configureForAliPay:(NSURL *)url
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            
            if ([[resultDic objectForKey:@"resultStatus"]intValue]==9000) {
                [YKAlipayTool sharedYKAlipayTool].paySuccess();
                DLog(@"成功");
            }else{
                [YKAlipayTool sharedYKAlipayTool].payFailed();
                DLog(@"失败");
            }
        }];
    }
}

#pragma mark - 微信支付的代理
-(void) onResp:(BaseResp*)resp{
    
    if ([resp isKindOfClass:[PayResp class]])
    {
        PayResp *response = (PayResp *)resp;
        switch (response.errCode) {
                case WXSuccess: {
                    DLog(@"支付成功");
                    [YKAlipayTool sharedYKAlipayTool].paySuccess();
                    break;
                }
                
            default: {
                [YKAlipayTool sharedYKAlipayTool].payFailed();
                DLog(@"支付失败");
                break;
            }
        }
    }
}

#pragma mark - 银联支付
- (void)configureForYinLian:(NSURL *)url
{
    DLog(@"%@",url.host);
    if ([url.host isEqualToString:@"uppayresult"]) {
        [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
            //结果code为成功时，先校验签名，校验成功后做后续处理
            if([code isEqualToString:@"success"]) {
                
                //判断签名数据是否存在
                if(data == nil){
                    //如果没有签名数据，建议商户app后台查询交易结果
                    return;
                }
                //数据从NSDictionary转换为NSString
                NSData *signData = [NSJSONSerialization dataWithJSONObject:data
                                                                   options:0
                                                                     error:nil];
                NSString *sign = [[NSString alloc] initWithData:signData encoding:NSUTF8StringEncoding];
                
                
                //验签证书同后台验签证书
                //此处的verify，商户需送去商户后台做验签
                if([self verify:sign]) {
                    //支付成功且验签成功，展示支付成功提示
                    [YKAlipayTool sharedYKAlipayTool].paySuccess();
                }
                else {
                    //验签失败，交易结果数据被篡改，商户app后台查询交易结果
                    [YKAlipayTool sharedYKAlipayTool].payFailed();
                }
            }
            else if([code isEqualToString:@"fail"]) {
                //交易失败
                [YKAlipayTool sharedYKAlipayTool].payFailed();
            }
            else if([code isEqualToString:@"cancel"]) {
                //交易取消
                [YKAlipayTool sharedYKAlipayTool].payFailed();
            }
        }];
    }
}

- (BOOL)verify:(id)sign
{
    return YES;
}

#pragma mark 创建tabbar
-(void)createTabbar{
    //创建window
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window = window;
    [self.window setBackgroundColor:[UIColor whiteColor]];
    
    if (!self.tabbar) {
        self.tabbar = [[WKTabbarController alloc] init];
        self.tabbar.delegate = (id)self;
    }
    //    SKStartPageViewController *page = [SKStartPageViewController new];
    //    [self.window setRootViewController:page];
    [self.window setRootViewController:self.tabbar];
    
    [self.window makeKeyAndVisible];
    
}

@end

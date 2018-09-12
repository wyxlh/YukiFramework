//
//  YKAlipayTool.m
//  YukiFramework
//
//  Created by 王宇 on 2018/5/31.
//  Copyright © 2018年 wy. All rights reserved.
//

#import "YKAlipayTool.h"
#import "APAuthInfo.h"
#import "APOrderInfo.h"
#import "APRSASigner.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
@implementation YKAlipayTool
SKSingleM(YKAlipayTool)


#pragma mark  支付宝支付
- (void)gopayForAlipay{
    NSString *appID = @"2018062760427268";
    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
    // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
    NSString *rsa2PrivateKey = @"MIIEwAIBADANBgkqhkiG9w0BAQEFAASCBKowggSmAgEAAoIBAQDZX+31s5eP6gQIzDniCOtyhqQU4JG4Rcv+L6g1ClXZHP4thO4cZOZ1H47OwOWXNJQuo8VtKvCZW1KpzAWPFkUGwsgJZZXznc2/w5eGs/rsXw1Ef8vGkX1KU5P9R1YQJnPqu/7nxBeYUMwqiqWtKQSYB8mYZhSYVqbqmEszUczlk6dkWIdbUbdqKu4v3PO1wY+QMXZFuq0tC2t9LvccEdc6/+PTb+MHKHlYX/KiU0zCLOAvi4lmzr15bG0gVl8K64yTF9kJBjIxi2wqhnLZhCr0s1XINCPihRyGDhpFgU5B+w5c33V8rnwxAYPDILoJY6DZfuQpl2WGMXe2Gm4pmlczAgMBAAECggEBAMFrrabibetdtMdLSfoKK88VZS06gg9w88ozB75ieu8c8EL6tJFJaxMuyHjKhcCcxXoWudagzcP30b9Kzmt6ymLwsORDo0FJ2klXNh5jSdRH49tex6jhzpVzdwx5DGiEfsKRE4mRH9mlk3YLNs603+STkVttAchn2lCGwOtiTyq7KhGCedyZwYkrl0OwwXdzs8yjhD81uNtBKACDRx42hnRDrCMyHa73dooVdnnYfV0zXc/hzAgaM7nZmKX/0fkgcAGrAP/2YTPittTlq2WVk/9nMG6du+4o46L2eta+GT9S4HQFiVo55eel+Vmb7sNw1z8ppj3ImPPPAS8rnHUWakECgYEA++Lfd2H4hF51bz4s2ZWPF3BLmXk4ERq7hClN5gkUPoKPaSHV4S7Fye1nW4mE8gPYOS/5RYyW0ACniJoOI77ZKdTx+dKWGQzNYHD9AcmU3kKvANa7BT6jHLGcGR1xMeQ7LCiXcZ4nu2twZhDpnNORp35K0VQbQCdi8tPM15X2aBMCgYEA3OzD6xAe7BUe1vGeGSH6jabDvErgBMxd8inbebucNhsD4h8gGCr0l4DePUFUcdGEFND153ZCHPHH9YUSpwN8j3wUQaqOCFZuvhlVCrobYGSm6PSo1OgyFOt6mLW1mU1nu/+5kF7kT6LLaiCFNa69H4bhJmcFdL5GcZyA9gY8eGECgYEA3Q/eyZqdDicMb6YknI1KuOpgHwCo+TH58mKBsGq1bqsNC9qbJ/bxtWd6d3a4y+Id6Qq2fZiGX2TDo/p4gFyloLX37CYqfy+iK4reMaxlz668gkLyfgbcBnnGIrCZQI0qdXXme9uuySjgy2L6dB2mTlZjeVWUWPh4Od8yft5pFCsCgYEAwP1LgHJKsO0aTaYv98CJAWjmn/vAijCE+OC7yzGqmlErKUMLZFFR7W8ztMr3G55tBUotJg9WXbaQeNfQnXkcPLOldl+pR3tJrmKuuXouJByI+gOP4L0d0syKAhDqHItTzRTtY0KhqzeI/qJ9+5EzwPCwij2AtKTrIKAYv9JezMECgYEA2Ic/7cVLleZ7fpMfCVg7iVp66sT2P2NYRu8orplqshLmGKC2jPY0BXRanDkd7gHXH2ouBUJh29PxZVboxgo+5LzibAeFZ1BqXfZMcU1Hsv/1gByTuJCB9HiK1ilJ46ggG8bk7l1WH6Dpm4c+JfeASNJIiSxrP43Vz3Z86s9C2ws=";
    NSString *rsaPrivateKey = @"";
    
    //partner和seller获取失败,提示
    if ([appID length] == 0 ||
        ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                       message:@"缺少appId或者私钥,请检查参数设置"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action){
                                                           
                                                       }];
        [alert addAction:action];
        //            [self presentViewController:alert animated:YES completion:^{ }];
        return;
    }
    //http://app.mikwine.com/api/goods/orders/notifications
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    APOrderInfo* order = [APOrderInfo new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type 根据商户设置的私钥来决定
    order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [APBizContent new];
    order.biz_content.body = @"我是测试数据";
    order.biz_content.subject = @"1";
    order.biz_content.out_trade_no = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格
    order.notify_url = @"http://app.mikwine.com/api/goods/orders/notifications";
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    APRSASigner* signer = [[APRSASigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:orderInfo withRSA2:YES];
    } else {
        signedString = [signer signString:orderInfo withRSA2:NO];
    }
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"com.wangyu.cn.YukiFramework";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
//        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
//                                 orderInfoEncoded, signedString];
        NSString *orderString = @"alipay_sdk=alipay-sdk-java-dynamicVersionNo&app_id=2018062760427268&biz_content=%7B%22body%22%3A%22%E6%88%91%E6%98%AF%E6%B5%8B%E8%AF%95%E6%95%B0%E6%8D%AE%22%2C%22out_trade_no%22%3A%2212345678910%22%2C%22product_code%22%3A%22QUICK_MSECURITY_PAY%22%2C%22subject%22%3A%22App%E6%94%AF%E4%BB%98%E6%B5%8B%E8%AF%95Java%22%2C%22timeout_express%22%3A%2230m%22%2C%22total_amount%22%3A%220.01%22%7D&charset=utf-8&format=json&method=alipay.trade.app.pay&notify_url=http%3A%2F%2Fnotifytest.free.ngrok.cc%2Ftmsapp%2Fv111%2Falipay%2Fnotify.do&sign=drEpUn2rvnrllb3KfqHdbV8WlTK8N2qgoOgv88ydejiqXGV2yC6YFVbugqDWHPBp4XfLCLQWmgNGfAhf4zk6MyRghFpy3RoYsOSaef6wNOkbZK4aUrowE%2BX3Q9p8dQ4gKWIaCPtqymIcxM17A7BphE%2B7ZisvY0YIFVDq5SWnsaKlHGrTz8zVPHlOEPRg6fUr1WI%2B1Kcd94gXEyompe7KN9eH5f3m1T2qXbioG0xv2gmWqYTd%2BBcAoPMd8gdk0pBqk0EmI%2BNYJQgMEMWB1%2BoiXNBpxtyIwxTDVl5fdPyo68ccBPI%2FvMlQesivzeLIU%2FvA83phRI8u3tE2dXW2c%2BeW%2BA%3D%3D&sign_type=RSA2&timestamp=2018-07-03+11%3A51%3A23&version=1.0";
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }
}

#pragma mark 微信支付
- (void)gopayForWeChat{
    NSString *prePayOrderNum = @"wx01131821681826070dbb1a412233025637";
    if (prePayOrderNum.length !=0  && [WXApi isWXAppInstalled]){
        
        //创建支付签名对象
        WXApiRequestHandler *req = [[WXApiRequestHandler alloc]init];
        //初始化支付签名对象
        [req init:WXAppId mch_id:WeiXinPartnerId];
        
        //设置密钥
        [req setKey:WeiXinPartnerKey];
        
        NSString *phoneIP = [self getPhoneIP];//手机IP
        NSString *TradeName = @"测试";//商品名
        NSString *PayMoney = [NSString stringWithFormat:@"%.2f",[self.totalPrice doubleValue]];//价格
        NSString *prepayId = prePayOrderNum;//获取prepayId（预支付交易会话标识）
        
        //获取到实际调起微信支付的参数后，在app端调起支付
        NSMutableDictionary *dict = [req sendPay:TradeName price:PayMoney PhoneIP:phoneIP WeixinprepayId:prepayId];
        
        if(dict == nil){
            //错误提示
            NSString *debug = [req getDebugifo];
            
            NSLog(@"%@\n\n",debug);
        }else{
            NSLog(@"%@\n\n",[req getDebugifo]);
            //[self alert:@"确认" msg:@"下单成功，点击OK后调起支付！"];
            
            NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
            
            //调起微信支付
            PayReq* req             = [[PayReq alloc] init];
            req.openID              = [dict objectForKey:@"appid"];
            req.partnerId           = [dict objectForKey:@"partnerid"];
            req.prepayId            = [dict objectForKey:@"prepayid"];
            req.nonceStr            = [dict objectForKey:@"noncestr"];
            req.timeStamp           = stamp.intValue;
            req.package             = [dict objectForKey:@"package"];
            req.sign                = [dict objectForKey:@"sign"];
            [WXApi sendReq:req];
        }
        
    }
}

#pragma mark 银联支付
- (void)gopayUnionpay{
    
    NSString *tradeNo = @"897646586994730884016";
    if (tradeNo.length > 0)
    {
        [[UPPaymentControl defaultControl] startPay:tradeNo fromScheme:@"com.wangyu.cn.YukiFramework" mode:YinLianZhengShi viewController:self.currentVC];   // mode  支付环境
    }
}
/**
 综合方法
 
 @param payType 支付方式
 @param orderNum  订单号
 @param totalPrice  支付金额
 */
- (void)gopayByPayType:(NSString *)payType orderNum:(NSString *)orderNum totalPrice:(NSString *)totalPrice currentViewController:(UIViewController *)currentViewController{
    if([payType containsString:@"支付宝"]){
        [self gopayForAlipay];
    }else if ([payType containsString:@"微信"]){
        [self gopayForWeChat];
    }else if ([payType containsString:@"银联"]){
        self.currentVC = currentViewController;
        [self gopayUnionpay];
    }
}

#pragma mark   ==============产生随机订单号==============

- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

//获取手机IP
- (NSString *)getPhoneIP {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    if ([address isEqualToString:@"error"])
    {
        address = @"192.168.1.1";
    }
    return address;
    
}

@end

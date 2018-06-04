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
    NSString *appID = @"2018012302042945";
    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
    // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
    NSString *rsa2PrivateKey = @"MIIEowIBAAKCAQEAvZMfVqSHDaMixszcdyVEW5IEj4PTFEQjL6QFYzAdWstVNKfFvRNL60AShCSHTFQhbqI5xXNT8pKG7QiTVtg76ES5otZU9o47/Cw6mkXLI7zgCdh2Cn+TkdNy+/oG8VM1rUOyqwTtD3OaXzffvIsEytVptUtNjeSkqu5yVVpxhunco3/peWo+XqYIzgiWz6IMXe2kOnyvb2yJO2r6V3+IIVy/nQxQwGZs1T+4WfU+Rnk/B6XDMfIFOuvmreaqLMaafIxLp9xIiFUsAPDmFhwXZTy+tXGha8AZrd9eGsC9HhZGiRdpaHth2gFV0zaXJUDzSiou6NQqOOJuMwkG5TfXNQIDAQABAoIBAQCxJGO5O34zQQhDCbTM5JbulhAK5tx7aHwUjUi3eYNEjxGsZUVBu2FKjxF+Rv/iVA71aUNgfLapyT+pCEVddirsjCOGxI6Z4SiuJ8oO1D7QwzH6ITmT78g+EH62c9i+8ckLgWHXqn+124kZhoVbke/FdQwU6yup9kfkrXFKznuc2xg7ldiPmnfSZvIB88KI1LfAkfF6pXGIOsh1foHV3N3WYKf9zo4ofyoAoPHa7PXgZ72/wpihLsneIDfySJaeph4x5DrbBw6HUAntuWBlJesISfr51Fe5IySidJtHHySaNT6DnFXaOKG1tDzyqaK3kb54ih4+0MRUa0FIojckhLVhAoGBAOao7+MgZPua1ETbb12F0FCecg8sN9UEoTjopxMB+r4aK/SQ8OHkXGKqZ8ZiNuhV4MJ1Tnft0oPpL0V3uii0xi5DfGlpf/aAYHVKBerJWECFYqohzh4SA1HHNzW9iNGOE1qfQT+4e01qzPTEzpXOIQfCZ5UDXOFnQqSUh7Hj6Vz9AoGBANJmtS3Xe/Fw6nLZdGnw3m9dEgUg1Y0C2UGqdesAuuWHkAt+Yxe2Molq+F/Pm9pWjkkyg3hhnAVHz/WW+LydjPMlyOLJNPbgjcallKtrcGUQUIVa05fT+bKhAMPslwL2b0O/SRY+DgAqrBsIIiEUsFJKUbdRYJSVJQusWB+IAZSZAoGAAc42un9pavLGUJerIn9GpyrmV6oP8dHsdSaVEDgGv3AzAeIUkKAZ/Qe6cjoYle7+KGeEqrmo2TF9Fj0eruzjVD9g/O4/ey18E871huX2k+K3Z/+FvoSDlCNMElaeeI11J1Nxzk7iYDPC0POtbkzDw2zJJMh29Ki7Q9CJ02GmVP0CgYAUiKmN+8XA3oBDDS3rWPKcc7zae0XcKTcCzZwMf1m+JOjN9lu9aK6t8p6i2yQevuvMAP4LtZsAeO22zjEgV0/2Ou3MFE7y+R9dD7PetvGVK25wVVjpLGrmIAhvFpv2Ug6x0e1UGmJLad66FKUgDWDX5yDqfyqp1ZRz+zHugduFoQKBgAdmY3KQY5m+fl0XSjuoAird/+OxqsEz041d2sFGUgObhZgy84RVsnznLH9GdPvHeXTRUgD/pCKpb7okknenNjpp9a/Rh5c8JdwAIdUZGjbT1ucvTFiswYq7Eh6BjZVE92OuB/vNjdCQlcihu31dPPNdzidq5py1rdGcVQRq+3v2";
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
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
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

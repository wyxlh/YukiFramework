//
//  YKAlipayTool.h
//  YukiFramework
//
//  Created by 王宇 on 2018/5/31.
//  Copyright © 2018年 wy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKSingle.h"
//支付宝
#import <AlipaySDK/AlipaySDK.h>
//微信
#import "WXApi.h"
#import "WXApiRequestHandler.h"
/**y银联支付*/
#import "UPPaymentControl.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^paySuccessBlock)(void);
typedef void(^payFailedBlock)(void);

@interface YKAlipayTool : NSObject
SKSingleH(YKAlipayTool)

/**
 支付宝支付
 */
- (void)gopayForAlipay;

/**
 微信支付
 */
- (void)gopayForWeChat;

/**
 银联支付
 */
- (void)gopayUnionpay;

/**
 订单号
 */
@property (nonatomic, copy) NSString *orderNum;

/**
支付方式 Id
 */
@property (nonatomic, copy) NSString *payTypeId;

/**
 订单总金额
 */
@property (nonatomic, copy) NSString *totalPrice;

/**
 银联支付需要的
 */
@property (nonatomic,strong) UIViewController *currentVC;

/**
 综合方法

 @param payType 支付方式
 @param orderNum  订单号
 @param totalPrice  支付金额
 */
- (void)gopayByPayType:(NSString *)payType orderNum:(NSString *)orderNum totalPrice:(NSString *)totalPrice currentViewController:(UIViewController *)currentViewController;

@property (nonatomic,copy) paySuccessBlock paySuccess;
@property (nonatomic,copy) payFailedBlock payFailed;

NS_ASSUME_NONNULL_END
@end

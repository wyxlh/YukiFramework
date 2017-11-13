//
//  WKRequest.m
//  YukiFramework
//
//  Created by 王宇 on 2017/11/13.
//  Copyright © 2017年 wy. All rights reserved.
//

#import "WKRequest.h"
#define TIMEOUT 10
@implementation WKRequest
/**
 *  get 网络请求
 *
 *  @param urlString    请求的网址字符串
 *  @param parameters   请求的参数
 *  @param successBlock 请求成功回调
 *  @param failureBlock 请求失败回调
 */
+(void)getWithURLString:(NSString *)urlString
             parameters:(id)parameters
                success:(SuccessBlock)successBlock
                failure:(FailureBlock)failureBlock{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //可以接受的类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //添加一种支持的类型
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", nil];
    //请求超时的时间
    manager.requestSerializer.timeoutInterval = TIMEOUT;
    //请求url
    NSString *hostUrl = [NSString stringWithFormat:@"%@%@",HOST_URL,urlString];
    [manager GET:hostUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            WKBaseModel *baseModel = [[WKBaseModel alloc]initWithJsonObject:dic];
            successBlock(baseModel);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}


/**
 *  post网络请求
 *
 *  @param urlString    请求的网址字符串
 *  @param parameters   请求的参数
 *  @param successBlock 请求成功回调
 *  @param failureBlock 请求失败回调
 */
+(void)postWithURLString:(NSString *)urlString
              parameters:(id)parameters
                 success:(SuccessBlock)successBlock
                 failure:(FailureBlock)failureBlock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //可以接受的类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //请求超时的时间
    manager.requestSerializer.timeoutInterval = TIMEOUT;
    //请求url
    NSString *hostUrl=[NSString stringWithFormat:@"%@%@",HOST_URL,urlString];
    [manager POST:hostUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            WKBaseModel *baseModel = [[WKBaseModel alloc]initWithJsonObject:dic];
            successBlock(baseModel);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
    
}

@end

//
//  YKPost.m
//  YukiFramework
//
//  Created by 王宇 on 2017/11/15.
//  Copyright © 2017年 wy. All rights reserved.
//

#import "YKPost.h"
#import "YKUser.h"
@implementation YKPost
//可空属性 决定属性是否可以为空 这个不可空
+(NSArray<NSString *> *)requiredProperties{
    return @[@"title"];
}

//忽略属性
+(NSArray<NSString *> *)ignoredProperties{
    return @[];
}

//反向关系
//+(NSDictionary<NSString *,RLMPropertyDescriptor *> *)linkingObjectsProperties{
//    return @{@""};
//}
//默认值
+(NSDictionary *)defaultPropertyValues{
    return @{@"look":@(0)};
}
//索引
+(NSArray<NSString *> *)indexedProperties{
    return @[@"title",@"timestamp"];
}

//主键
+(NSString *)primaryKey{
    return @"Id";
}
@end

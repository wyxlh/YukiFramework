//
//  YKShopModel.m
//  YukiFramework
//
//  Created by 王宇 on 2017/11/14.
//  Copyright © 2017年 wy. All rights reserved.
//

#import "YKShopModel.h"

@implementation YKShopModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"list":@"YKListModel"};
}

@end

@implementation YKListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"Id":@"id"};
}

@end

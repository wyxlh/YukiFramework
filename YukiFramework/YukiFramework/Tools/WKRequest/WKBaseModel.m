//
//  WKbaseModel.m
//  YukiFramework
//
//  Created by 王宇 on 2017/11/13.
//  Copyright © 2017年 wy. All rights reserved.
//

#import "WKBaseModel.h"

@implementation WKBaseModel

-(instancetype)initWithJsonObject:(NSDictionary *)aJson{
    self = [super init];
    
    if (self) {
        if (aJson && [aJson isKindOfClass:[NSDictionary class]]) {
            self.mDictionary = [NSMutableDictionary dictionaryWithDictionary:aJson];
            self.result       = [aJson objectForKey:@"result"];
            self.reason       = [aJson objectForKey:@"reason"];
            self.errorCode    = [aJson objectForKey:@"error_code"];
        }
    }
    
    return self;
}

-(NSString *)result{
    return [self.mDictionary objectForKey:@"result"];
}

-(NSString *)message{
    return [self.mDictionary objectForKey:@"reason"];
}

-(NSString *)errorCode{
    return [self.mDictionary objectForKey:@"error_Code"];
    
}

@end

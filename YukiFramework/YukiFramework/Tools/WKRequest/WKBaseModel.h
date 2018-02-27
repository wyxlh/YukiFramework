//
//  WKbaseModel.h
//  YukiFramework
//
//  Created by 王宇 on 2017/11/13.
//  Copyright © 2017年 wy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKBaseModel : NSObject
@property (nonatomic, strong, nullable) NSMutableDictionary     *mDictionary;
@property (nonatomic, copy, nullable)   NSString                *result;
@property (nonatomic, copy, nullable)   NSString                *reason;
@property (nonatomic, copy, nullable)   NSString                *errorCode;
-(instancetype _Nullable )initWithJsonObject:(NSDictionary *_Nonnull)aJson;
@end

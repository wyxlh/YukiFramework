//
//  YKShopListModel.h
//  YukiFramework
//
//  Created by 王宇 on 2017/11/14.
//  Copyright © 2017年 wy. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface YKShopListModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *steps;
@end

@interface YKStepsModel : NSObject
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *step;
NS_ASSUME_NONNULL_END
@end


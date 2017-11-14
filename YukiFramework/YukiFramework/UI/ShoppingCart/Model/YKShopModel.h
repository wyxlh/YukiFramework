//
//  YKShopModel.h
//  YukiFramework
//
//  Created by 王宇 on 2017/11/14.
//  Copyright © 2017年 wy. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface YKShopModel : NSObject
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, copy)   NSString *name;
@end

@interface YKListModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *parentId;
NS_ASSUME_NONNULL_END
@end





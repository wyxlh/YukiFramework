//
//  YKUser.h
//  YukiFramework
//
//  Created by 王宇 on 2017/11/15.
//  Copyright © 2017年 wy. All rights reserved.
//

#import <Realm/Realm.h>
#import "YKPost.h"
@interface YKUser : RLMObject
@property NSString *nickName;
@property RLMArray <YKPost *><YKPost> *post;
@end

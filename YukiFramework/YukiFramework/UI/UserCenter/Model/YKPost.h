//
//  YKPost.h
//  YukiFramework
//
//  Created by 王宇 on 2017/11/15.
//  Copyright © 2017年 wy. All rights reserved.
//

#import <Realm/Realm.h>
@class YKUser;
 RLM_ARRAY_TYPE(YKPost)
@interface YKPost : RLMObject
//主键 不可更改的
@property NSString *Id;
/**
 标题
 */
@property NSString *title;
/**
 作者 一对一 或一对多
 */
@property (readonly) RLMLinkingObjects *author;
/**
 时间戳
 */
@property NSDate *timestamp;
/**
 内容
 */
@property NSData *content;
/**
 流量量
 */
@property NSNumber<RLMInt> *look;
/**
 回帖
 */
@property RLMArray <YKPost*><YKPost> *comment;
/**
 是否置顶
 */
@property NSNumber <RLMBool> *isTop;
//不支持 cgfloat 请用 double float
@end

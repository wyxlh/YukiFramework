//
//  DogModel.h
//  YukiFramework
//
//  Created by 王宇 on 2017/11/15.
//  Copyright © 2017年 wy. All rights reserved.
//

#import <Realm/Realm.h>

@interface DogModel : RLMObject
//reaml 官方文档建议不要去标记他 就这样
@property NSString *name;
@property NSInteger age;
@end

//
//  YKPerson.h
//  YukiFramework
//
//  Created by 王宇 on 2017/11/15.
//  Copyright © 2017年 wy. All rights reserved.
//

#import <Realm/Realm.h>
#import "DogModel.h"
RLM_ARRAY_TYPE(DogModel)
@interface YKPerson : RLMObject
@property NSString *name;
@property RLMArray<DogModel*><DogModel> *dogs;
@end

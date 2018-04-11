//
//  YKGCDUIService.h
//  YukiFramework
//
//  Created by 王宇 on 2018/4/11.
//  Copyright © 2018年 wy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKGCDViewModel.h"
@interface YKGCDUIService : NSObject<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) YKGCDViewModel *viewModel;
@end

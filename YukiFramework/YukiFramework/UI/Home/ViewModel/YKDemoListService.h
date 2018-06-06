//
//  YKDemoListService.h
//  YukiFramework
//
//  Created by 王宇 on 2018/6/6.
//  Copyright © 2018年 wy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKDemoListViewModel.h"
@interface YKDemoListService : NSObject <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) YKDemoListViewModel *viewModel;
@end

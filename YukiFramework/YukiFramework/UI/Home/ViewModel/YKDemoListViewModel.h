//
//  YKDemoListViewModel.h
//  YukiFramework
//
//  Created by 王宇 on 2018/6/6.
//  Copyright © 2018年 wy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKDemoListViewModel : NSObject
@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, copy) void (^jumpBlock)(UIViewController *);

- (void)setUIWithSuccess:(void(^)(void))success;

- (void)jumpVCWithSelectSection:(NSInteger)section SelectIndex:(NSInteger)index;


@end

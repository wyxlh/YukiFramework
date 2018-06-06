//
//  YKScorllView.h
//  侧滑Demo
//
//  Created by 王宇 on 2018/4/3.
//  Copyright © 2018年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKScorllView : UIView

/**
  初始化
 @param dataArray 所要滚动的数据（这里我们模仿在直播间切换房间的场景，那么这里就是所有的主播列表数据）
 */
-(instancetype)initWithScorllDataArray:(NSArray *)dataArray;

@end

//
//  YKShopStepTableViewCell.h
//  YukiFramework
//
//  Created by 王宇 on 2017/11/14.
//  Copyright © 2017年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YKStepsModel;
@interface YKShopStepTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *step;
@property (nonatomic, strong) YKStepsModel *model;
@end

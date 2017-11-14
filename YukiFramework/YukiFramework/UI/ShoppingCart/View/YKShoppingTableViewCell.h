//
//  YKShoppingTableViewCell.h
//  YukiFramework
//
//  Created by 王宇 on 2017/11/14.
//  Copyright © 2017年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YKListModel;
@interface YKShoppingTableViewCell : UITableViewCell
@property (weak, nonatomic, nullable) IBOutlet UIImageView *imgview;
@property (weak, nonatomic, nullable) IBOutlet UILabel *titleName;
@property (nonatomic, strong, nullable) YKListModel *model;
@end

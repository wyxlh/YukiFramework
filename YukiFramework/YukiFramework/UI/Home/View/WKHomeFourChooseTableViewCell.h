//
//  WKHomeFourChooseTableViewCell.h
//  WKFrameDemo
//
//  Created by 王宇 on 2017/6/8.
//  Copyright © 2017年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeModel;
@interface WKHomeFourChooseTableViewCell : UITableViewCell
@property (weak, nonatomic, nullable) IBOutlet UILabel *titleName;
@property (nonatomic, strong, nullable) HomeModel *model;
@end

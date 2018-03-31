//
//  YKSubtitleTableViewCell.m
//  YukiFramework
//
//  Created by 王宇 on 2018/3/31.
//  Copyright © 2018年 wy. All rights reserved.
//

#import "YKSubtitleTableViewCell.h"

@implementation YKSubtitleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    int R = (arc4random() % 256) ;
    int G = (arc4random() % 256) ;
    int B = (arc4random() % 256) ;
    self.backgroundColor=CustomColor(R, G, B, 1);
    //因为 tableView 旋转的180° 所以 cell 也需要旋转
    self.transform = CGAffineTransformMakeScale(1, -1);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

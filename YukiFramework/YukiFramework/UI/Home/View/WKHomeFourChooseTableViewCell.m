//
//  WKHomeFourChooseTableViewCell.m
//  WKFrameDemo
//
//  Created by 王宇 on 2017/6/8.
//  Copyright © 2017年 wy. All rights reserved.
//

#import "WKHomeFourChooseTableViewCell.h"
#import "HomeModel.h"
@interface WKHomeFourChooseTableViewCell()

@end

@implementation WKHomeFourChooseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
}

-(void)setModel:(HomeModel *)model{
    self.titleName.text = model.province;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

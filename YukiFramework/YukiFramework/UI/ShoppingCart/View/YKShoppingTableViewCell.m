//
//  YKShoppingTableViewCell.m
//  YukiFramework
//
//  Created by 王宇 on 2017/11/14.
//  Copyright © 2017年 wy. All rights reserved.
//

#import "YKShoppingTableViewCell.h"
#import "YKShopModel.h"
@implementation YKShoppingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    SKViewsBorder(self.imgview, 20, 0, [UIColor redColor]);
    // Initialization code
}

-(void)setModel:(YKListModel *)model{
    self.titleName.text = model.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

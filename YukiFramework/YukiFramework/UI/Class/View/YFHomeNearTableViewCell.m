//
//  YFHomeNearTableViewCell.m
//  YFKit
//
//  Created by 王宇 on 2018/6/14.
//  Copyright © 2018年 wy. All rights reserved.
//

#import "YFHomeNearTableViewCell.h"

@implementation YFHomeNearTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setDict:(NSDictionary *)dict{
//    self.title.text                             = [dict safeJsonObjForKey:@"name"];
//    self.detaleDes.text                         = [NSString stringWithFormat:@"距您%@米    %@",[dict safeJsonObjForKey:@"distance"],[dict safeJsonObjForKey:@"address"]];
}
@end

//
//  YKPayAlipayOrderStringView.m
//  YukiFramework
//
//  Created by 王宇 on 2019/3/14.
//  Copyright © 2019 wy. All rights reserved.
//

#import "YKPayAlipayOrderStringView.h"

@implementation YKPayAlipayOrderStringView


- (IBAction)clickBtn:(id)sender {
    [self endEditing:YES];
    [self removeFromSuperview];
    !self.payAliPayBlock ? : self.payAliPayBlock();
}

@end

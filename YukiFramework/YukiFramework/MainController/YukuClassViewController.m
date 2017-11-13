//
//  YukuClassViewController.m
//  YukiFramework
//
//  Created by 王宇 on 2017/11/9.
//  Copyright © 2017年 wy. All rights reserved.
//

#import "YukuClassViewController.h"

@interface YukuClassViewController ()

@end

@implementation YukuClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    self.title = @"分类";
    [self addRightItems:1 rightItem1Name:@"back" isImage1:YES rightItem2:@"返回" isImage2:NO];
}

-(void)rightItem1ButtonClick:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

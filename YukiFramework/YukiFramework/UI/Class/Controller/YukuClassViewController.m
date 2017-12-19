//
//  YukuClassViewController.m
//  YukiFramework
//
//  Created by 王宇 on 2017/11/9.
//  Copyright © 2017年 wy. All rights reserved.
//

#import "YukuClassViewController.h"

@interface YukuClassViewController ()
    @property (weak, nonatomic) IBOutlet UIView *bgView;
    @property (nonatomic, strong) NSArray *urls;

@end

@implementation YukuClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    self.title = @"分类";
    [self addRightItems:2 rightItem1Name:@"back" isImage1:YES rightItem2:@"返回" isImage2:NO];
    [self setup];
}

- (void)setup{
        self.urls = @[@"http://ww4.sinaimg.cn/bmiddle/a15bd3a5jw1f12r9ku6wjj20u00mhn22.jpg",
                      @"http://ww2.sinaimg.cn/bmiddle/a15bd3a5jw1f01hkxyjhej20u00jzacj.jpg",
                      @"http://ww4.sinaimg.cn/bmiddle/a15bd3a5jw1f01hhs2omoj20u00jzwh9.jpg",
                      @"http://ww2.sinaimg.cn/bmiddle/a15bd3a5jw1ey1oyiyut7j20u00mi0vb.jpg",
                      @"http://ww2.sinaimg.cn/bmiddle/a15bd3a5jw1exkkw984e3j20u00miacm.jpg",
                      @"http://ww4.sinaimg.cn/bmiddle/a15bd3a5jw1ezvdc5dt1pj20ku0kujt7.jpg",
                      @"http://ww3.sinaimg.cn/bmiddle/a15bd3a5jw1ew68tajal7j20u011iacr.jpg",
                      @"http://ww2.sinaimg.cn/bmiddle/a15bd3a5jw1eupveeuzajj20hs0hs75d.jpg",
                      @"http://ww2.sinaimg.cn/bmiddle/d8937438gw1fb69b0hf5fj20hu13fjxj.jpg"];
    SDCycleScrollView *cycleScrollView          = [[SDCycleScrollView alloc]initWithFrame:self.bgView.bounds];
    cycleScrollView.imageURLStringsGroup        = self.urls;
    cycleScrollView.clickItemOperationBlock     = ^(NSInteger currentIndex){
        
    };
    cycleScrollView.currentPageDotColor         = [UIColor redColor];
    cycleScrollView.pageControlAliment          = SDCycleScrollViewPageContolAlimentCenter;
    [self.bgView addSubview:cycleScrollView];
    
}
-(void)rightItem1ButtonClick:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

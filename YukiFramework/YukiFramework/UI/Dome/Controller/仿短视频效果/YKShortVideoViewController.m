//
//  YKShortVideoViewController.m
//  YukiFramework
//
//  Created by 王宇 on 2018/6/6.
//  Copyright © 2018年 wy. All rights reserved.
//

#import "YKShortVideoViewController.h"
#import "YKScorllView.h"
@interface YKShortVideoViewController ()
@property (nonatomic, strong) NSArray *urls;
@end

@implementation YKShortVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title                      = @"仿短视频效果";
    self.urls                       = @[@"http://ww4.sinaimg.cn/bmiddle/a15bd3a5jw1f12r9ku6wjj20u00mhn22.jpg",
                                        @"http://ww2.sinaimg.cn/bmiddle/a15bd3a5jw1f01hkxyjhej20u00jzacj.jpg",
                                        @"http://ww4.sinaimg.cn/bmiddle/a15bd3a5jw1f01hhs2omoj20u00jzwh9.jpg",
                                        @"http://ww2.sinaimg.cn/bmiddle/a15bd3a5jw1ey1oyiyut7j20u00mi0vb.jpg",
                                        @"http://ww2.sinaimg.cn/bmiddle/a15bd3a5jw1exkkw984e3j20u00miacm.jpg",
                                        @"http://ww4.sinaimg.cn/bmiddle/a15bd3a5jw1ezvdc5dt1pj20ku0kujt7.jpg",
                                        @"http://ww3.sinaimg.cn/bmiddle/a15bd3a5jw1ew68tajal7j20u011iacr.jpg",
                                        @"http://ww2.sinaimg.cn/bmiddle/a15bd3a5jw1eupveeuzajj20hs0hs75d.jpg",
                                        @"http://ww2.sinaimg.cn/bmiddle/d8937438gw1fb69b0hf5fj20hu13fjxj.jpg"];
    YKScorllView *scorll            = [[YKScorllView alloc]initWithScorllDataArray:self.urls];
    [self.view addSubview:scorll];
}


@end

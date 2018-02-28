//
//  YukiStaticLibraryViewController.m
//  YukiFramework
//
//  Created by 王宇 on 2018/2/28.
//  Copyright © 2018年 wy. All rights reserved.
//

#import "YukiStaticLibraryViewController.h"
#import "StaticText.h"
@interface YukiStaticLibraryViewController ()

@end

@implementation YukiStaticLibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title                   = @"制作静态库";
    StaticText *text             = [[StaticText alloc]init];
    [text sayHello];
    self.progressColor           = [UIColor greenColor];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.jianshu.com/p/0e84e299020c"]]];
}


@end

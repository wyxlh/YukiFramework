//
//  YukiShowPhotoWebViewController.m
//  YukiFramework
//
//  Created by 王宇 on 2018/1/19.
//  Copyright © 2018年 wy. All rights reserved.
//

#import "YukiShowPhotoWebViewController.h"

@interface YukiShowPhotoWebViewController ()

@end

@implementation YukiShowPhotoWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    //拦截 url
    NSString *urlString =navigationAction.request.URL.absoluteString;
    DLog(@"%@",urlString);
    if ([urlString containsString:@"PostDetail/ProductDetail/ProductId="]) {
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}
@end

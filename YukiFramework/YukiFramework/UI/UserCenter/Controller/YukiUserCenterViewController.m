//
//  YukiUserCenterViewController.m
//  YukiFramework
//
//  Created by 王宇 on 2017/11/9.
//  Copyright © 2017年 wy. All rights reserved.
//

#import "YukiUserCenterViewController.h"
#import "DogModel.h"
#import "YKPerson.h"
#import "YKPost.h"
#import "YKUser.h"
@import WebKit;
@interface YukiUserCenterViewController ()<WKUIDelegate,WKNavigationDelegate,UIWebViewDelegate>
@property (nonatomic, strong)WKWebView *mainWeb;
//@property (nonatomic, strong) UIWebView *mainWeb;
@end


@implementation YukiUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    [self addRightTitleBtn:@"swift"];
    [self.mainWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://appapi.jimvia.com/ProductDetail.aspx?proId=25871"]]];
    //创建一个数据库 记录狗狗的名字和年龄
//    DogModel *dog = [[DogModel alloc]init];
//    dog.name = @"pater";
//    dog.age = 1;
//    //添加一个主人的记录
//    YKPerson *person = [[YKPerson alloc]init];
//    person.name = @"mike";
//    [person.dogs addObject:dog];
//    DLog(@"%@",person);
//    //查询年龄小于2岁的狗
//    RLMResults *results = [DogModel objectsWhere:@"age < 2"];
//    DLog(@"%@",results);
//    //添加狗狗
//    RLMRealm *realm = [RLMRealm defaultRealm];
//    [realm transactionWithBlock:^{
//        [realm addObject:dog];
//    }];
//    //线程操作
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
//        RLMRealm *reaml = [RLMRealm defaultRealm];
//        [reaml beginWriteTransaction];
//
//        [reaml commitWriteTransaction];
//
//    });
    
}

- (WKWebView *)mainWeb
{
    if (!_mainWeb) {
        // 根据JS字符串初始化WKUserScript对象
        static  NSString * const jsGetImages =
            @"function getImages(){\
            var objs = document.getElementsByTagName(\"img\");\
            for(var i=0;i<objs.length;i++){\
            objs[i].onclick=function(){\
            document.location=\"myweb:imageClick:\"+this.src;\
            };\
            };\
            return objs.length;\
            };";
        WKUserScript *script = [[WKUserScript alloc] initWithSource:jsGetImages injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//
//        // 根据生成的WKUserScript对象，初始化WKWebViewConfiguration
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        [config.userContentController addUserScript:script];
        _mainWeb = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - TabbarHeight)configuration:config];
        _mainWeb.navigationDelegate = self;
        _mainWeb.UIDelegate = self;
        [self.view addSubview:_mainWeb];
    }
    return _mainWeb;
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    //js方法遍历图片添加点击事件 返回图片个数
    static  NSString * const jsGetImages =
    @"function getImages(){\
    var objs = document.getElementsByTagName(\"img\");\
    for(var i=0;i<objs.length;i++){\
    objs[i].onclick=function(){\
    document.location=\"myweb:imageClick:\"+this.src;\
    };\
    };\
    return objs.length;\
    };";
    DLog(@"%@",jsGetImages);
    [webView evaluateJavaScript:@"getImages()" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
         NSLog(@"value: %@ error: %@", response, error);
    }];

}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSString *urlString =navigationAction.request.URL.absoluteString;
    DLog(@"%@",urlString);
    if ([urlString containsString:@"PostDetail/ProductDetail/ProductId="]) {
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}




-(void)rightTitleButtonClick:(UIButton *)sender{

}



@end

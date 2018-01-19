//
//  YukiUserCenterViewController.m
//  YukiFramework
//
//  Created by 王宇 on 2017/11/9.
//  Copyright © 2017年 wy. All rights reserved.
//

#import "YukiUserCenterViewController.h"
#import "YukiWebViewController.h"
#import "YukiShowPhotoWebViewController.h"
#import "ViewController.h"
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
    [self addRightTitleBtn:@"网页"];
    [self addLeftTitleBtn:@"网页图片"];
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

-(void)leftTitleButtonClick:(UIButton *)sender{
    YukiShowPhotoWebViewController *photo = [YukiShowPhotoWebViewController new];
    photo.title = @"网页图片";
    photo.hidesBottomBarWhenPushed = YES;
//    photo.progressColor = [UIColor redColor];
    photo.urlString = @"https://www.baidu.com";
    [self.navigationController pushViewController:photo animated:YES];
}



#pragma mark  跳转动画
-(void)rightTitleButtonClick:(UIButton *)sender{
    YukiWebViewController *vc= [YukiWebViewController new];
    //UIModalTransitionStyleFlipHorizontal 翻转
    
    //UIModalTransitionStyleCoverVertical 底部滑出
    
    //UIModalTransitionStyleCrossDissolve 渐显
    
    //UIModalTransitionStylePartialCurl 翻页

//    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [self presentViewController:vc animated:YES completion:nil];
    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController.view.layer addAnimation:[self createTransitionAnimation] forKey:nil];
    vc.urlString = @"http://appapi.jimvia.com/ProductDetail.aspx?proId=25871";
    vc.title = @"网页详情";
    vc.progressColor = [UIColor redColor];
    [self.navigationController pushViewController:vc animated:YES];
}

-(CATransition *)createTransitionAnimation
{
    //切换之前添加动画效果
    //后面知识: Core Animation 核心动画
    //不要写成: CATransaction
    //创建CATransition动画对象
    CATransition *animation = [CATransition animation];
    ////转场动画类型
//    cube---立方体
//    suckEffect  吸走的效果
//    oglFlip 前后翻转效果
//    rippleEffect 波纹效果
//    pageCurl 翻页起来
//    pageUnCurl 翻页下来
//    cameraIrisHollowOpen
//    镜头开
//    @"cameraIrisHollowClose " 镜头关
    //设置动画的类型:
    animation.type = @"rippleEffect";
    //设置动画的方向
    animation.subtype = kCATransitionFromBottom;
    //设置动画的持续时间
    animation.duration = 1.5;
    //设置动画速率(可变的)
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //动画添加到切换的过程中
    return animation;
}




@end

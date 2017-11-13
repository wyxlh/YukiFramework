//
//  YukiBaseViewController.m
//  YukiFramework
//
//  Created by 王宇 on 2017/11/9.
//  Copyright © 2017年 wy. All rights reserved.
//

#import "YukiBaseViewController.h"

@interface YukiBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation YukiBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.navigationController viewControllers].count>1) {
        [self addBackItem];
    }
}

/**
 加载返回按钮,在第一层的时候就不需要加调用
 */
-(void)addBackItem{
    [self.backItem setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
}
/**
 返回按钮
 */
-(UIButton *)backItem{
    if (!_backItem) {
        _backItem                                = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backItem addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem                = [[UIBarButtonItem alloc]initWithCustomView:_backItem];
        self.navigationItem.leftBarButtonItem    = leftItem;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    return _backItem;
}

/**
 返回
 */
-(void)clickBack:(UIButton *)sender{
    [self goBack];
}

-(UIButton *)leftTitleBtn{
    if (!_leftTitleBtn) {
        _leftTitleBtn                             = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftTitleBtn addTarget:self action:@selector(leftTitleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *titleItem                = [[UIBarButtonItem alloc]initWithCustomView:_leftTitleBtn];
        self.navigationItem.leftBarButtonItem     = titleItem;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    return _leftTitleBtn;
}

/**
 传入你需要的文字

 @param leftTitleBtnName leftTitleBtnName
 */
-(void)addLeftTitleBtn:(NSString *)leftTitleBtnName{
    if (leftTitleBtnName.length != 0)
    {
        if (_backItem != nil) {
            [_backItem removeFromSuperview];
        }
        [self.leftTitleBtn setTitle:leftTitleBtnName forState:UIControlStateNormal];
    }
}

-(UIButton *)leftImageBtn{
    if (!_leftImageBtn) {
        _leftImageBtn                              = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftImageBtn addTarget:self action:@selector(leftImageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *titleItem                 = [[UIBarButtonItem alloc]initWithCustomView:_leftImageBtn];
        self.navigationItem.leftBarButtonItem      = titleItem;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    return _leftImageBtn;
}

/**
 传入你的图片名字

 @param leftImageBtnName leftImageBtnName
 */
-(void)addLeftImageBtn:(NSString *)leftImageBtnName{
    if (leftImageBtnName.length != 0)
    {
        if (_backItem != nil) {
            [_backItem removeFromSuperview];
        }
        [self.leftImageBtn setImage:[UIImage imageNamed:leftImageBtnName] forState:UIControlStateNormal];
    }
}

-(UIButton *)rightTitleBtn{
    if (!_rightTitleBtn) {
        _rightTitleBtn                                = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightTitleBtn addTarget:self action:@selector(rightTitleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *titleItem                    = [[UIBarButtonItem alloc]initWithCustomView:_rightTitleBtn];
        self.navigationItem.rightBarButtonItem        = titleItem;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    return _rightTitleBtn;
}

/**
  传入你需要的文字

 @param rightTitleBtnName rightTitleBtnName 
 */
-(void)addRightTitleBtn:(NSString *)rightTitleBtnName{
    if (rightTitleBtnName.length != 0) {
        [self.rightTitleBtn setTitle:rightTitleBtnName forState:UIControlStateNormal];
    }
}

-(UIButton *)rightImageBtn{
    if (!_rightImageBtn) {
        _rightImageBtn                                = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightImageBtn addTarget:self action:@selector(rightImageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *titleItem                    = [[UIBarButtonItem alloc]initWithCustomView:_rightImageBtn];
        self.navigationItem.rightBarButtonItem        = titleItem;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    return _rightImageBtn;
}

/**
 传入图片名字

 @param rightImageBtnName rightImageBtnName 
 */
-(void)addRightImageBtn:(NSString *)rightImageBtnName{
    if (rightImageBtnName.length != 0) {
        [self.rightImageBtn setImage:[UIImage imageNamed:rightImageBtnName] forState:UIControlStateNormal];
    }
}

/**
 返回
 */
-(void)goBack{
    NSArray* vcarr = [self.navigationController viewControllers];
    if (vcarr.count > 1)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

-(void)leftTitleButtonClick:(UIButton *)sender{
    DLog(@"用到文字的时候重写leftTitleButtonClick方法");
}

-(void)leftImageButtonClick:(UIButton *)sender{
    DLog(@"用到图片的时候重写leftImageButtonClick方法");
}

-(void)rightTitleButtonClick:(UIButton *)sender{
    DLog(@"用到图片的时候重写rightTitleButtonClick方法");
}

-(void)rightImageButtonClick:(UIButton *)sender{
    DLog(@"用到图片的时候重写rightImageButtonClick方法");
}

/**
 选中的 tabbar

 @param index  第几个
 */
-(void)selectTabbarIndex:(NSInteger )index{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.tabbar appointTabbarIndex:index];
}

/**
 *  指定哪一个Tabbar上面有一个小红点。为0 就不显示了
 *
 *  @param badgeValue 数量
 *  @param index      index
 */
-(void)selectBadgeValue:(NSInteger)badgeValue toIndex:(NSInteger)index{
    AppDelegate *Delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [Delegate.tabbar appointbadgeValue:badgeValue toIndex:index];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

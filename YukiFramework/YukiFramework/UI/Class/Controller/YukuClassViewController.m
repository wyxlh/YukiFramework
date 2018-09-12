//
//  YukuClassViewController.m
//  YukiFramework
//
//  Created by 王宇 on 2017/11/9.
//  Copyright © 2017年 wy. All rights reserved.
//

#import "YukuClassViewController.h"
#import "YFHomeNearTableViewCell.h"

@interface YukuClassViewController ()<UITableViewDelegate,UITableViewDataSource>{
    int lastContentOffset;
}
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic, strong) NSArray *urls;
@property (nonatomic, strong) UIView *tView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL istop;
@end

@implementation YukuClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    self.title = @"分类";
    [self addRightItems:2 rightItem1Name:@"back" isImage1:YES rightItem2:@"返回" isImage2:NO];
    [self setup];
    [self.view addSubview:self.tView];
    [self.tView addSubview:self.tableView];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(clickpan:)];
    [self.tableView addGestureRecognizer:pan];
}

- (void)clickpan: (UIPanGestureRecognizer *)rec{
    
    CGPoint point = [rec translationInView:self.view];
    DLog(@"qqwqwqwqwqeewe%f",point.y);
    NSLog(@"%f,%f",point.x,point.y);
    if (point.y > 0) {
        [self dissperTableView];
    }
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

#pragma mark
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YFHomeNearTableViewCell *cell               = [tableView dequeueReusableCellWithIdentifier:@"YFHomeNearTableViewCell" forIndexPath:indexPath];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DLog(@"-----------------");
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    lastContentOffset = scrollView.contentOffset.y;
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat hight = scrollView.frame.size.height;
    CGFloat contentOffset = scrollView.contentOffset.y;
    CGFloat distanceFromBottom = scrollView.contentSize.height - contentOffset;
    CGFloat offset = contentOffset - lastContentOffset;
    lastContentOffset = contentOffset;
    
    if (offset > 0 && contentOffset > 0) {
        DLog(@"上拉行为 + %f",offset);
        self.istop = NO;
        [UIView animateWithDuration:0.5 animations:^{
            self.tView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-TabbarHeight);
            self.tableView.frame = CGRectMake(0, 100, ScreenWidth, ScreenHeight-TabbarHeight-100);
        }];
    }
    if (offset < 0 && distanceFromBottom > hight) {
        DLog(@"下拉行为");
        if (self.tView.y == ScreenHeight-NavHeight-400 && contentOffset < 0) {
            self.istop = YES;
        }
    }
    if (contentOffset == 0) {
        DLog(@"滑动到顶部");
        if (self.tView.y == ScreenHeight - NavHeight -400 && self.istop) {
            [self dissperTableView];
        }else{
            [UIView animateWithDuration:0.25 animations:^{
                self.tView.frame = CGRectMake(0, ScreenHeight-NavHeight-400, ScreenWidth, 400);
                self.tableView.frame = CGRectMake(0, 100, ScreenWidth, 300);
            }];
        }
    }
    if (distanceFromBottom < hight) {
        DLog(@"滑动到底部");
    }

}

- (void)dissperTableView{
//    self.lookBtn.hidden                         = NO;
//    self.topMapView.hidden                      = YES;
    [UIView animateWithDuration:0.25 animations:^{
//        self.mapView.height                     = self.view.height;
        self.tView.y                        = ScreenHeight;
    }];
}

//-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
//    DLog(@"2");
//}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    DLog(@"结束滑动");
}



#pragma mark TableView
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView                              = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, ScreenWidth, 300) style:UITableViewStylePlain];
        _tableView.delegate                     = self;
        _tableView.dataSource                   = self;
        _tableView.rowHeight                    = 70;
        _tableView.bounces                      = NO;
        [_tableView registerNib:[UINib nibWithNibName:@"YFHomeNearTableViewCell" bundle:nil] forCellReuseIdentifier:@"YFHomeNearTableViewCell"];
    }
    return _tableView;
}

- (UIView *)tView{
    if (!_tView) {
        _tView                                 = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-TabbarHeight-400, ScreenWidth, 400)];
        _tView.backgroundColor                 = [UIColor redColor];
    }
    return _tView;
}




@end

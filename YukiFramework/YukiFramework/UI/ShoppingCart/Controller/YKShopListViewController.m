//
//  YKShopListViewController.m
//  YukiFramework
//
//  Created by 王宇 on 2017/11/14.
//  Copyright © 2017年 wy. All rights reserved.
//
#import "YKShopListViewController.h"
#import "YKShopStepTableViewCell.h"
#import "YKShopListModel.h"
#import "YKShopListHeadView.h"
#import "HSGifHeader.h"
#import "ViewController.h"
@interface YKShopListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) UIView *bgView;// 阴影视图
@property (nonatomic, strong) UIView *tempView;
@property (nonatomic, strong) NSMutableArray <YKShopListModel *> *dataArr;
@end

@implementation YKShopListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self netWork];
}

-(void)setup{
    self.title                                      = @"菜谱列表";
    self.dataArr                                    = [NSMutableArray new];
    self.page                                       = 1;
    self.tableView.delegate                         = self;
    self.tableView.dataSource                       = self;
    self.tableView.rowHeight                        = 100;
    [self.tableView registerNib:[UINib nibWithNibName:@"YKShopStepTableViewCell" bundle:nil] forCellReuseIdentifier:@"YKShopStepTableViewCell"];
    @weakify(self)
    self.tableView.mj_footer                        = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        @strongify(self)
        self.page ++;
        [self netWork];
    }];
    self.tableView.mj_header                        = [HSGifHeader headerWithRefreshingBlock:^{
        @strongify(self)
        self.page                                   = 1;
        [self netWork];
    }];
}

-(void)netWork{
    NSMutableDictionary *parmas                     = [NSMutableDictionary dictionary];
    [parmas setValue:@"c64315f6d82013410b0ed0ef66ce50a9" forKey:@"key"];
    [parmas setValue:self.menu forKey:@"menu"];
    [parmas setValue:self.Id forKey:@"cid"];
    [parmas setValue:@"10" forKey:@"rn"];
    [parmas setValue:@(self.page) forKey:@"pn"];
    @weakify(self)
    [WKRequest postWithURLString:@"http://apis.juhe.cn/cook/index" parameters:parmas success:^(WKBaseModel *baseModel) {
        @strongify(self)
        if (self.page == 1) {
            self.dataArr                                = [YKShopListModel mj_objectArrayWithKeyValuesArray:[[baseModel.mDictionary objectForKey:@"result"] objectForKey:@"data"]];
        }else{
            [self.dataArr addObjectsFromArray:[YKShopListModel mj_objectArrayWithKeyValuesArray:[[baseModel.mDictionary objectForKey:@"result"] objectForKey:@"data"]]];
        }
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.dataArr[section] steps] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YKShopStepTableViewCell *cell                       = [tableView dequeueReusableCellWithIdentifier:@"YKShopStepTableViewCell" forIndexPath:indexPath];
    cell.model                                          = [self.dataArr[indexPath.section] steps][indexPath.row];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    YKShopListHeadView *headView                        = [[[NSBundle mainBundle] loadNibNamed:@"YKShopListHeadView" owner:nil options:nil] lastObject];
    headView.title.text                                 = [self.dataArr[section] title];
    return headView;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    //x和y的最终值为1
    [UIView animateWithDuration:0.5 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ViewController *VC                              = [[ViewController alloc]init];
    //插入动画
    CGRect rectInTableView                          = [tableView rectForRowAtIndexPath:indexPath];
    CGRect sourceRect                               = [tableView convertRect:rectInTableView toView:[tableView superview]];
    UITableViewCell * selectedCell                  = (UITableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    selectedCell.frame                              = sourceRect;
    selectedCell.backgroundColor                    = [UIColor whiteColor];
    [self.view addSubview:selectedCell];
    [self.view addSubview:self.bgView];
    [self.view bringSubviewToFront:selectedCell];
    self.tempView                                   = [[UIView alloc] initWithFrame:selectedCell.frame];
    self.tempView.backgroundColor                   = [UIColor whiteColor];
    self.tempView.alpha                             = 0;
    [self.view addSubview:self.tempView];
    // 进行动画
    [UIView animateWithDuration:0.3 animations:^{
        selectedCell.transform                      = CGAffineTransformMakeScale(1.0, 1.1);
        self.tempView.alpha                         = 1;
    }];
    
    double delayInSeconds                           = 0.3;
    __block YKShopListViewController* bself         = self;
    dispatch_time_t popTime                         = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [selectedCell removeFromSuperview];
        // 进行动画
        [UIView animateWithDuration:0.3 animations:^{
            bself.tempView.transform                = CGAffineTransformMakeScale(1.0, ScreenHeight / bself.tempView.frame.size.height * 2);
        }];
    });
    
    double delayInSeconds2 = 0.5;
    dispatch_time_t popTime2 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds2 * NSEC_PER_SEC));
    dispatch_after(popTime2, dispatch_get_main_queue(), ^(void){
        // 进行动画
        [UIView animateWithDuration:0.3 animations:^{
            [self.navigationController pushViewController:VC animated:NO];
        } completion:^(BOOL finished) {
            [bself.tempView removeFromSuperview];
            [bself.bgView removeFromSuperview];
        }];
    });
}

// 阴影视图
- (UIView *)bgView {
    if (nil == _bgView) {
        _bgView                                       = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _bgView.backgroundColor                       = [UIColor colorWithWhite:0 alpha:0.5];
    }
    return _bgView;
}


@end

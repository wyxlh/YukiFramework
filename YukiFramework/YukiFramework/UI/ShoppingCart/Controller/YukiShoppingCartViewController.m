//
//  YukiShoppingCartViewController.m
//  YukiFramework
//
//  Created by 王宇 on 2017/11/9.
//  Copyright © 2017年 wy. All rights reserved.
//

#import "YukiShoppingCartViewController.h"
#import "YKShoppingTableViewCell.h"
#import "YKShopModel.h"
#import "YKShopHeadView.h"
#import "YKShopListViewController.h"
#import "HSGifHeader.h"
@interface YukiShoppingCartViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSArray <YKShopModel *>*dataArr;
@end

@implementation YukiShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self netWork];
}

-(void)setup{
    self.title                                      = @"菜谱";
    self.page                                       = 1;
    self.tableView.delegate                         = self;
    self.tableView.dataSource                       = self;
    self.tableView.rowHeight                        = 60;
    [self.tableView registerNib:[UINib nibWithNibName:@"YKShoppingTableViewCell" bundle:nil] forCellReuseIdentifier:@"YKShoppingTableViewCell"];
    @weakify(self)
    self.tableView.mj_header                        = [HSGifHeader headerWithRefreshingBlock:^{
        @strongify(self)
        [self netWork];
    }];
}

-(void)netWork{
    NSMutableDictionary *parmas                     = [NSMutableDictionary dictionary];
    [parmas setValue:@"c64315f6d82013410b0ed0ef66ce50a9" forKey:@"key"];
    @weakify(self)
    [WKRequest postWithURLString:@"http://apis.juhe.cn/cook/category" parameters:parmas success:^(WKBaseModel *baseModel) {
        @strongify(self)
        self.dataArr                                = [YKShopModel mj_objectArrayWithKeyValuesArray:baseModel.result];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.dataArr[section] list] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YKShoppingTableViewCell *cell                   = [tableView dequeueReusableCellWithIdentifier:@"YKShoppingTableViewCell" forIndexPath:indexPath];
    cell.model                                      = [self.dataArr[indexPath.section] list][indexPath.row];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    YKShopHeadView *headView                        = [[[NSBundle mainBundle] loadNibNamed:@"YKShopHeadView" owner:nil options:nil] lastObject];
    headView.title.text                             = [self.dataArr[section] name];
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
//给tableView家动画
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    //x和y的最终值为1
    [UIView animateWithDuration:0.5 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YKShopListViewController *list                  = [YKShopListViewController new];
    list.menu                                       = [[self.dataArr[indexPath.section] list][indexPath.row] name];
    list.Id                                         = [[self.dataArr[indexPath.section] list][indexPath.row] Id];
    list.hidesBottomBarWhenPushed                   = YES;
    [self.navigationController pushViewController:list animated:YES];
}

@end

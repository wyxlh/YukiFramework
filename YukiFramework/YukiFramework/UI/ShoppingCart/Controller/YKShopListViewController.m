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
@interface YKShopListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger page;
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

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end

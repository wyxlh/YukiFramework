//
//  YukiHomeViewController.m
//  YukiFramework
//
//  Created by 王宇 on 2017/11/9.
//  Copyright © 2017年 wy. All rights reserved.
//

#import "YukiHomeViewController.h"
#import "WKHomeFourChooseTableViewCell.h"
#import "YukuClassViewController.h"
#import "HomeModel.h"
@interface YukiHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong, nullable) NSArray<HomeModel *>*dataArr;
@end

@implementation YukiHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor                       = [UIColor whiteColor];
    self.title                                      = @"首页";
    [self setup];
    [self netWork];
}

-(void)setup{
    self.tableView.delegate                         = self;
    self.tableView.dataSource                       = self;
    self.tableView.rowHeight                        = 60.0f;
    [self.tableView registerNib:[UINib nibWithNibName:@"WKHomeFourChooseTableViewCell" bundle:nil] forCellReuseIdentifier:@"WKHomeFourChooseTableViewCell"];
}

#pragma mark  网络请求
-(void)netWork{
    @weakify(self)
    [WKRequest getWithURLString:@"" parameters:@{@"key":@"cd6a73e91e71f792ca5a70313c37ee23"} success:^(WKBaseModel *baseModel) {
        @strongify(self)
        self.dataArr                               = [HomeModel mj_objectArrayWithKeyValuesArray:baseModel.result];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WKHomeFourChooseTableViewCell *cell             = [tableView dequeueReusableCellWithIdentifier:@"WKHomeFourChooseTableViewCell" forIndexPath:indexPath];
    cell.model                                      = self.dataArr[indexPath.row];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YukuClassViewController *view                    = [YukuClassViewController new];
    view.hidesBottomBarWhenPushed                    = YES;
    [self.navigationController pushViewController:view animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

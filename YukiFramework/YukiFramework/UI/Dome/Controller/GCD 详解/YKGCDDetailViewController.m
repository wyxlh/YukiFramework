//
//  YKGCDDetailViewController.m
//  YukiFramework
//
//  Created by 王宇 on 2018/4/4.
//  Copyright © 2018年 wy. All rights reserved.
//

#import "YKGCDDetailViewController.h"
#import "YKGCDTableViewCell.h"
#import "YKGCDUIService.h"
#import "YKGCDViewModel.h"
@interface YKGCDDetailViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YKGCDViewModel *viewModel;
@property (nonatomic, strong) YKGCDUIService *service;
@end

@implementation YKGCDDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}
#pragma mark 获取数据
-(void)setUI{
    self.title = @"GCD 详解(看控制台打印)";
    @weakify(self)
    [self.viewModel getData:^{
        @strongify(self)
        [self.tableView reloadData];
    } failureBlock:^{
        
    }];
}

#pragma mark tableView
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView                          = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-TabbarHeight) style:UITableViewStylePlain];
        _tableView.delegate                 = self.service;
        _tableView.dataSource               = self.service;
        _tableView.estimatedRowHeight       = 60;
        [_tableView registerNib:[UINib nibWithNibName:@"YKGCDTableViewCell" bundle:nil] forCellReuseIdentifier:@"YKGCDTableViewCell"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark  - viewModel
-(YKGCDViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel                            = [[YKGCDViewModel alloc]init];
    }
    return _viewModel;
}

#pragma mark  - service
-(YKGCDUIService *)service{
    if (!_service) {
        _service                              = [[YKGCDUIService alloc]init];
        _service.viewModel                    = self.viewModel;
    }
    return _service;
}

@end

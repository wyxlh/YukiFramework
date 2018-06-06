//
//  YukiDemoListViewController.m
//  YukiFramework
//
//  Created by 王宇 on 2018/1/22.
//  Copyright © 2018年 wy. All rights reserved.
//

#import "YukiDemoListViewController.h"

#import "YKDemoListService.h"
#import "YKDemoListViewModel.h"
@interface YukiDemoListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) YKDemoListService *service;
@property (nonatomic, strong) YKDemoListViewModel *viewModel;
@end

@implementation YukiDemoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

-(void)setup{
    self.title                  = @"Dome列表";
    
    self.tableView.delegate     = self.service;
    self.tableView.dataSource   = self.service;
    
    @weakify(self)
    [self.viewModel setUIWithSuccess:^{
        @strongify(self)
        [self.tableView reloadData];
    }];
    
}

#pragma mark service
-(YKDemoListService *)service{
    if (!_service) {
        _service                 = [[YKDemoListService alloc]init];
        _service.viewModel       = self.viewModel;
    }
    return _service;
}

#pragma mark viewModel
-(YKDemoListViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel               = [[YKDemoListViewModel alloc]init];
        @weakify(self)
        _viewModel.jumpBlock     = ^(UIViewController *viewCtrl){
            @strongify(self)
            [self.navigationController pushViewController:viewCtrl animated:YES];
        };
    }
    return _viewModel;
}


@end

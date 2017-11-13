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
@interface YukiHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation YukiHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor                       = [UIColor whiteColor];
    self.title                                      = @"首页";
    [self setup];
}

-(void)setup{
    self.tableView.delegate                         = self;
    self.tableView.dataSource                       = self;
    self.tableView.rowHeight                        = 60.0f;
    [self.tableView registerNib:[UINib nibWithNibName:@"WKHomeFourChooseTableViewCell" bundle:nil] forCellReuseIdentifier:@"WKHomeFourChooseTableViewCell"];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WKHomeFourChooseTableViewCell *cell             = [tableView dequeueReusableCellWithIdentifier:@"WKHomeFourChooseTableViewCell" forIndexPath:indexPath];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YukuClassViewController *view                    = [YukuClassViewController new];
    view.hidesBottomBarWhenPushed                    = YES;
    [self.navigationController pushViewController:view animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

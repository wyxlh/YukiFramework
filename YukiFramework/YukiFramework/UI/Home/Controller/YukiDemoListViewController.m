//
//  YukiDemoListViewController.m
//  YukiFramework
//
//  Created by 王宇 on 2018/1/22.
//  Copyright © 2018年 wy. All rights reserved.
//

#import "YukiDemoListViewController.h"
#import "YukiCollectionSuspensionViewController.h"
#import "YukiShoppingCartViewController.h"
#import "YukiShowPhotoWebViewController.h"
#import "YukiTitleScorllViewController.h"
#import "WKAttributdeLblViewController.h"
@interface YukiDemoListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;
@end

@implementation YukiDemoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

-(void)setup{
    self.title                              = @"Dome列表";
    self.dataArr                            = @[@[@"CollectionView头部悬浮",@"加载网页的进度条",@"TitleScorllView"],@[@"TableView动画",@"富文本设置"]];
    [self.tableView reloadData];
}

#pragma mark UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArr[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ideitifier             = @"aCell";
    UITableViewCell *cell                   = [tableView dequeueReusableCellWithIdentifier:ideitifier];
    if (!cell) {
        cell                                = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ideitifier];
    }
    cell.accessoryType                      = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text                     = self.dataArr[indexPath.section][indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //CollectionView头部悬浮
            YukiCollectionSuspensionViewController *suspen = [YukiCollectionSuspensionViewController new];
            [self.navigationController pushViewController:suspen animated:YES];
        }else if (indexPath.row == 1){
            //加载网页的进度条
            YukiShowPhotoWebViewController *web            = [YukiShowPhotoWebViewController new];
            web.title                                      = @"网页进度条";
            web.urlString                                  = @"https://www.baidu.com";
            web.progressColor                              = NavColor;
            [self.navigationController pushViewController:web animated:YES];
        }else if (indexPath.row == 2){
            YukiTitleScorllViewController *titleScorll     = [YukiTitleScorllViewController new];
            [self.navigationController pushViewController:titleScorll animated:YES];
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            //TableView动画
            YukiShoppingCartViewController *shopping       = [YukiShoppingCartViewController new];
            [self.navigationController pushViewController:shopping animated:YES];
        }else if (indexPath.row == 1){
            WKAttributdeLblViewController *att             = [WKAttributdeLblViewController new];
            [self.navigationController pushViewController:att animated:YES];
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
@end

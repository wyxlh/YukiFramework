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
#import "YukiDemoListViewController.h"
#import "HomeModel.h"
@interface YukiHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong, nullable) NSArray<HomeModel *>*dataArr;
@end

@implementation YukiHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = YES;
    self.view.backgroundColor                       = [UIColor whiteColor];
    self.title                                      = @"首页";
    [self setup];
    NSArray *cityArr                                = [SKUserDefaults objectForKey:@"HomeData"];
    if (cityArr.count == 0) {
        [self netWork];
    }else{
        self.dataArr                                = [HomeModel mj_objectArrayWithKeyValuesArray:cityArr];
        [self.tableView reloadData];
    }

}

-(void)setup{
    [self addRightTitleBtn:@"Demo列表"];
    self.tableView.delegate                         = self;
    self.tableView.dataSource                       = self;
    self.tableView.rowHeight                        = 60.0f;
    [self.tableView registerNib:[UINib nibWithNibName:@"WKHomeFourChooseTableViewCell" bundle:nil] forCellReuseIdentifier:@"WKHomeFourChooseTableViewCell"];
}

#pragma mark  网络请求
-(void)netWork{
    @weakify(self)
    [WKRequest getWithURLString:@"/historyWeather/province" parameters:@{@"key":@"cd6a73e91e71f792ca5a70313c37ee23"} success:^(WKBaseModel *baseModel) {
        @strongify(self)
        self.dataArr                               = [HomeModel mj_objectArrayWithKeyValuesArray:baseModel.result];
        [SKUserDefaults setObject:baseModel.result forKey:@"HomeData"];
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView

{
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithBgColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:self.tableView.contentOffset.y / 200]] forBarMetrics:UIBarMetricsDefault];
    
}

-(UIImage *)imageWithBgColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}

#pragma mark  demo 列表

-(void)rightTitleButtonClick:(UIButton *)sender{
    YukiDemoListViewController *demo                  = [YukiDemoListViewController new];
    demo.hidesBottomBarWhenPushed                     = YES;
    [self.navigationController pushViewController:demo animated:YES];
}


@end

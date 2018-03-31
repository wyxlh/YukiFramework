//
//  YKLiveCommentViewController.m
//  YukiFramework
//
//  Created by 王宇 on 2018/3/31.
//  Copyright © 2018年 wy. All rights reserved.
//

#import "YKLiveCommentViewController.h"
#import "YKSubtitleTableViewCell.h"
@interface YKLiveCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation YKLiveCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DLog(@"222");
    [self setup];
}

-(void)setup{
    self.title                                    = @"仿直播间评论效果";
    self.view.backgroundColor                     = [UIColor whiteColor];
    NSArray *titleArr                                  = @[@"哈哈哈哈哈哈哈哈哈",@"嘿嘿嘿嘿嘿黑黑黑",@"嘿嘿嘿嘿嘿黑黑黑"];
    self.dataArr                                  = [NSMutableArray array];
    [self.dataArr addObjectsFromArray:titleArr];
    //需要把 tableView 旋转180°, 因为评论都是从下往上的, 所以需要把 tableView 倒过来.比较好处理
    self.tableView.transform = CGAffineTransformMakeScale(1, -1);
    //添加 按钮
    [self addRightTitleBtn:@"添加"];
}

#pragma mark UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YKSubtitleTableViewCell *cell                 = [tableView dequeueReusableCellWithIdentifier:@"YKSubtitleTableViewCell" forIndexPath:indexPath];
    cell.title.text                               = self.dataArr[indexPath.row];
    return cell;
}
#pragma mark  添加数据
-(void)rightTitleButtonClick:(UIButton *)sender{
    NSMutableArray *indexPaths                    = [[NSMutableArray alloc] init];
    NSIndexPath *indexPath                        = [NSIndexPath indexPathForRow:0 inSection:0];
    NSString *title                               = @"哈哈哈哈哈哈哈嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿二黑嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿二黑嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿二黑嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿二黑嘿嘿嘿嘿嘿嘿嘿混合";
    [self.dataArr insertObject:title atIndex:0];
    [indexPaths addObject: indexPath];
    //在执行添加或者删除的时候必须执行这个
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView endUpdates];
    
}

#pragma mark tableView懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView                                = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NavHeight) style:UITableViewStylePlain];
        _tableView.delegate                       = self;
        _tableView.dataSource                     = self;
        _tableView.estimatedRowHeight             = YES;
        _tableView.estimatedRowHeight             = 60;
        [_tableView registerNib:[UINib nibWithNibName:@"YKSubtitleTableViewCell" bundle:nil] forCellReuseIdentifier:@"YKSubtitleTableViewCell"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end

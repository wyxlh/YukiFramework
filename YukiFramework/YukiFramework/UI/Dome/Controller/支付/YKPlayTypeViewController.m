//
//  YKPlayTypeViewController.m
//  YukiFramework
//
//  Created by 王宇 on 2018/5/31.
//  Copyright © 2018年 wy. All rights reserved.
//

#import "YKPlayTypeViewController.h"
#import "YKPayAlipayOrderStringView.h"
#import "YKAlipayTool.h"
@interface YKPlayTypeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong, nullable) YKPayAlipayOrderStringView *alipayView;
@property (nonatomic, strong, nullable) NSArray *dataArr,*imgArr;
@end

@implementation YKPlayTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title                                    = @"支付方式";
    self.dataArr                                  = @[@[@"支付宝"],@[@"微信支付"],@[@"银联"]];
    self.imgArr                                   = @[@[@"Alipay"],@[@"wechat"],@[@"UnionPay"]];
    self.tableView.estimatedRowHeight             = 0;
    self.tableView.estimatedSectionFooterHeight   = 0;
    self.tableView.estimatedSectionHeaderHeight   = 0;
    
    [self addRightTitleBtn:@"结束"];
}

- (void)rightTitleButtonClick:(UIButton *)sender {
    [self.view endEditing:YES];
}

#pragma mark UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ideitifier             = @"aCell";
    UITableViewCell *cell                   = [tableView dequeueReusableCellWithIdentifier:ideitifier];
    if (!cell) {
        cell                                = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ideitifier];
    }
    cell.accessoryType                      = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text                     = self.dataArr[indexPath.section][indexPath.row];
    cell.imageView.image                    = [UIImage imageNamed:self.imgArr[indexPath.section][indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
//        [[YKAlipayTool sharedYKAlipayTool] gopayByPayType:@"支付宝" orderNum:@"" totalPrice:@"" currentViewController:self];
        [self.view addSubview:self.alipayView];
        
    }else if (indexPath.section == 1){
//        [[YKAlipayTool sharedYKAlipayTool] gopayByPayType:@"微信" orderNum:@"" totalPrice:@"0.01" currentViewController:self];
        [self.view addSubview:self.alipayView];
    }else if (indexPath.section == 2){
        [[YKAlipayTool sharedYKAlipayTool] gopayByPayType:@"银联" orderNum:@"" totalPrice:@"0.01" currentViewController:self];
    }
    [YKAlipayTool sharedYKAlipayTool].paySuccess = ^{
        DLog(@"成功");
    };
    [YKAlipayTool sharedYKAlipayTool].payFailed  = ^{
        DLog(@"失败");
    };
   
}


- (YKPayAlipayOrderStringView *)alipayView {
    if (!_alipayView) {
        _alipayView = [[[NSBundle mainBundle] loadNibNamed:@"YKPayAlipayOrderStringView" owner:nil options:nil] firstObject];
        _alipayView.frame = self.view.bounds;
        WS(weakSelf)
        _alipayView.payAliPayBlock = ^{
            [weakSelf gotoPay];
        };
    }
    return _alipayView;
}

- (void)gotoPay {
    DLog(@"%@",self.alipayView.textView.text);
    [[YKAlipayTool sharedYKAlipayTool] gopayByPayType:@"微信" orderNum:self.alipayView.textView.text totalPrice:@"" currentViewController:self];
    [YKAlipayTool sharedYKAlipayTool].paySuccess = ^{
        DLog(@"成功");
    };
    [YKAlipayTool sharedYKAlipayTool].payFailed  = ^{
        DLog(@"失败");
    };
}



@end

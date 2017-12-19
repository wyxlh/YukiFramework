//
//  YukiUserCenterViewController.m
//  YukiFramework
//
//  Created by 王宇 on 2017/11/9.
//  Copyright © 2017年 wy. All rights reserved.
//

#import "YukiUserCenterViewController.h"
#import "DogModel.h"
#import "YKPerson.h"
#import "YKPost.h"
#import "YKUser.h"
@interface YukiUserCenterViewController ()

@end


@implementation YukiUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    [self addRightTitleBtn:@"swift"];
    //创建一个数据库 记录狗狗的名字和年龄
//    DogModel *dog = [[DogModel alloc]init];
//    dog.name = @"pater";
//    dog.age = 1;
//    //添加一个主人的记录
//    YKPerson *person = [[YKPerson alloc]init];
//    person.name = @"mike";
//    [person.dogs addObject:dog];
//    DLog(@"%@",person);
//    //查询年龄小于2岁的狗
//    RLMResults *results = [DogModel objectsWhere:@"age < 2"];
//    DLog(@"%@",results);
//    //添加狗狗
//    RLMRealm *realm = [RLMRealm defaultRealm];
//    [realm transactionWithBlock:^{
//        [realm addObject:dog];
//    }];
//    //线程操作
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
//        RLMRealm *reaml = [RLMRealm defaultRealm];
//        [reaml beginWriteTransaction];
//
//        [reaml commitWriteTransaction];
//
//    });
    
}

-(void)rightTitleButtonClick:(UIButton *)sender{

}



@end

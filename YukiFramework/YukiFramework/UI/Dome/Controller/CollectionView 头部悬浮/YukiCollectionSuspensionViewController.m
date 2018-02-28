//
//  YukiCollectionSuspensionViewController.m
//  YukiFramework
//
//  Created by 王宇 on 2018/1/22.
//  Copyright © 2018年 wy. All rights reserved.
//

#import "YukiCollectionSuspensionViewController.h"
#import "YukiCollectionViewFlowLayout.h"
#import "WKCategoryCollectionViewCell.h"
#import "WKCateSectionHeadCollectionReusableView.h"
@interface YukiCollectionSuspensionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation YukiCollectionSuspensionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

-(void)setup{
    self.title                             = @"collectionView头部悬浮";
    self.dataArr                           = [NSMutableArray new];
    for (int i = 0; i < 15; i ++) {
        NSMutableArray *itemArr            = [NSMutableArray new];
        for (int j = 0; j < 5; j ++) {
            [itemArr addObject:@(j)];
        }
        [self.dataArr addObject:itemArr];
    }
   
    [self.collectionView reloadData];
}

#pragma mark  UICollectionViewDelegate,UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArr.count;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.dataArr[section] count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WKCategoryCollectionViewCell *cell      = [collectionView dequeueReusableCellWithReuseIdentifier:@"WKCategoryCollectionViewCell" forIndexPath:indexPath];
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        WKCateSectionHeadCollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WKCateSectionHeadCollectionReusableView" forIndexPath:indexPath];
        headView.title.text                               = [NSString stringWithFormat:@"第%ld区",indexPath.section];
        return headView;
    }
    return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake(0, 40);
}

#pragma mark collection 懒加载
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        YukiCollectionViewFlowLayout *layout        = [[YukiCollectionViewFlowLayout alloc]init];
        layout.itemSize                             = CGSizeMake(ScreenWidth/2-5, 40);
        layout.naviHeight                           = 40;
        _collectionView                             = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NavHeight) collectionViewLayout:layout];
        _collectionView.backgroundColor             = [UIColor whiteColor];
        _collectionView.dataSource                  = self;
        _collectionView.delegate                    = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"WKCategoryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"WKCategoryCollectionViewCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"WKCateSectionHeadCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WKCateSectionHeadCollectionReusableView"];

        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}
@end

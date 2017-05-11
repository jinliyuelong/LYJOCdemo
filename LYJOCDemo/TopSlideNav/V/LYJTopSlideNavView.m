//
//  LYJTopSlideNavView.m
//  LYJOCDemo
//
//  Created by Liyanjun on 2017/3/17.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

#import "LYJTopSlideNavView.h"
#import "LYJTopSlideCollectionViewCell.h"

@interface LYJTopSlideNavView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;


@property (nonatomic, strong)NSMutableArray<LYJTopSlideModel *> * dataSource;


@property (nonatomic, strong)UIColor* selectColor;

@end

@implementation LYJTopSlideNavView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        
        [self initialization];
    }
    
    return self;
    
    
}
- (instancetype)init{
    self = [super init];
    if(self){
        
        [self initialization];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
        
        [self initialization];
    }
    
    return self;
    
}

- (void)initialization
{
    
    [self addSubview:self.collectionView];
    
    
    self.selectColor = [UIColor clearColor];
    
    [self collectionViewSetF];
}

#pragma mark - 懒加载


- (UICollectionViewFlowLayout *)flowLayout
{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        
        
        _flowLayout.minimumInteritemSpacing = MasScale_1080(0);//纵线间距
        
        
        _flowLayout.estimatedItemSize =  CGSizeMake(MasScale_1080(20), MasScale_1080(80));
        
        
        [_flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
    }
    
    
    return _flowLayout;
    
    
}



- (UICollectionView *)collectionView
{
    
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        
        
        
        
        [self collectionViewSetP];
        
    }
    
    return _collectionView;
    
    
    
    
}

- (void)collectionViewSetP
{
    
    // [_collectionView setBackgroundColor:[UIColor yellowColor]];
    
    
    _collectionView.layer.cornerRadius = 2.f;
    
    _collectionView.layer.masksToBounds = YES;
    
    
    
    
    [_collectionView setBackgroundColor:[UIColor whiteColor]];
    
    
    [_collectionView setDelegate:self];
    
    [_collectionView setDataSource:self];
    
    
    
    
    [_collectionView setShowsHorizontalScrollIndicator:NO];
    
    [_collectionView setAlwaysBounceHorizontal:YES];
    
    
    
    
    //注册cell
//    
    [_collectionView registerClass:[LYJTopSlideCollectionViewCell class] forCellWithReuseIdentifier:[LYJTopSlideCollectionViewCell registerCellID]];
    
    
    
    
    
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellId"];
    
    
    
    
}


- (void)collectionViewSetF{
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self);
        
    }];
    
    
}



#pragma mark - setUi

#pragma mark - 加载数据

#pragma mark - delegate

#pragma mark -- UICollectionViewDelegate



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
   
    for (LYJTopSlideModel* model in self.dataSource) {
        model.isSelectTed = NO;
    }
    
    
    LYJTopSlideModel* model = self.dataSource[indexPath.row];
    
    
    model.isSelectTed = YES;
    
    
    [self.dataSource replaceObjectAtIndex:indexPath.row withObject:model];
    

 
 
    [self.collectionView reloadData];
  
    
  
//        [self.collectionView reloadData];
    
  
    
   
    
    
    
    
    
    
}




#pragma mark -- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSInteger numb = 1;
    
    
    return numb;
    
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger numb = self.dataSource.count;
    
    return numb;
    
}






- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
   
    LYJTopSlideCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[LYJTopSlideCollectionViewCell registerCellID] forIndexPath:indexPath];
    
    
    
    [cell dataBind:self.dataSource[indexPath.row]];
    
   
    
    return cell;

    
    
    
    
}


#pragma mark -- UICollectionViewDelegateFlowLayout
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    CGFloat w =  MasScale_1080(204) ;
//    
//    
//    
//    
//    
//    CGFloat h = MasScale_1080(212);
//    
//    
//    
//    
//    
//    return CGSizeMake(w, h);
//}
//
//
//
//内编剧
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    CGFloat top = 0;
    
    CGFloat left = 0;
    
    CGFloat right = 0;
    
    CGFloat bot =  0;
    
    
    
    return UIEdgeInsetsMake(top, left, bot, right);
    
    
}
////横向间距;

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    CGFloat gap = MasScale_1080(0);//
    
    
    
    
    return gap;
    
    
    
    
}


#pragma mark - 实例方法


- (void)dataBind:(NSMutableArray<LYJTopSlideModel*> *)dataSource {

    self.dataSource = dataSource;
    
    
    [self.collectionView reloadData];

}


#pragma mark - 类方法

@end

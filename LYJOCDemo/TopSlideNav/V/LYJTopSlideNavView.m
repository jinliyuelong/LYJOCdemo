//
//  LYJTopSlideNavView.m
//  LYJOCDemo
//
//  Created by Liyanjun on 2017/3/17.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

#import "LYJTopSlideNavView.h"

@interface LYJTopSlideNavView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

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
    
    
}

#pragma mark - 懒加载


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
    
    
    
    
    [_collectionView setAlwaysBounceHorizontal:YES];
    
    
    
    
    //注册cell
//    
//    [_collectionView registerClass:[QuickServiceCollectionViewCell class] forCellWithReuseIdentifier:[QuickServiceCollectionViewCell registerCellID]];
    
    
    
    
    
    
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
    
    
    
    
    NSLog(@"选中了");
    
    
    
}




#pragma mark -- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSInteger numb = 1;
    
    
    return numb;
    
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger numb = 5;
    
    return numb;
    
}






- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellId" forIndexPath:indexPath];
    
    
    
   
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
////内编剧
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    
//    CGFloat top = 0;
//    
//    CGFloat left = 0;
//    
//    CGFloat right = 0;
//    
//    CGFloat bot =  0;
//    
//    
//    
//    return UIEdgeInsetsMake(top, left, bot, right);
//    
//    
//}
////横向间距;
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    CGFloat gap = MasScale_1080(0);//
//    
//    
//    
//    
//    return gap;
//    
//    
//    
//    
//}


#pragma mark - 实例方法

#pragma mark - 类方法

@end

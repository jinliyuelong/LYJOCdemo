//
//  LYJTopSlideCollectionViewCell.m
//  LYJOCDemo
//
//  Created by Liyanjun on 2017/3/17.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

#import "LYJTopSlideCollectionViewCell.h"

static NSString* const CollectionCellId=@"LYJTopSlideCollectionViewCellId";

@interface LYJTopSlideCollectionViewCell()



@property (nonatomic, strong)UILabel *bottomlable;

@property (nonatomic, strong)UIView *lineView;

@end

@implementation LYJTopSlideCollectionViewCell


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialization];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialization];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}


#pragma mark - 初始化

- (void)initialization{
    
    [self setupUi];
    
}


#pragma mark -- setupUi

- (void)setupUi{
    

    
}
#pragma mark - 懒加载





#pragma mark  - delegate


#pragma mark - 实例方法



#pragma mark - 类方法
+ (NSString *)registerCellID
{
    
    return CollectionCellId;
    
}

@end

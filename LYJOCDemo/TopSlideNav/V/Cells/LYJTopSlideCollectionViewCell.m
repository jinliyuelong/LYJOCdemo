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




@property (nonatomic, strong)UIView* bottomLineView;


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
    
    self.backgroundColor = [UIColor whiteColor];
    

    [self.contentView addSubview:self.contentLable];
    
    [self contentLableF];
    
    [self setContenViewF];
    
}

- (void)setContenViewF{
    
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        
        make.leading.mas_equalTo(self.mas_leading).offset(0);
        
        make.trailing.mas_equalTo(self.mas_trailing).offset(0);
        
        make.bottom.mas_equalTo(self);
        
        
    }];
    
}

#pragma mark - 懒加载

- (UILabel *)contentLable{

    if (!_contentLable) {
        
        _contentLable = [[UILabel alloc] init];
        
        _contentLable.textColor = [UIColor blackColor];
        
        _contentLable.text = @"测试内容";
        
        _contentLable.font = [UIFont systemFontOfSize:MasScale_1080(42)];

    }
    
    
    return _contentLable;


}

- (void)contentLableF{

    [_contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(MasScale_1080(mycommonEdge_1080));
       
        make.leading.mas_equalTo(self.contentView.mas_leading).mas_offset(MasScale_1080(mycommonEdge_1080));
        
        
        make.trailing.mas_equalTo(self.contentView.mas_trailing).mas_offset(MasScale_1080(-mycommonEdge_1080)).priority(600);
        
         make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(MasScale_1080(-mycommonEdge_1080)).priority(600);
        
    }];

}



#pragma mark  - delegate


#pragma mark - 实例方法

- (void)dataBind:(LYJTopSlideModel*)model{

    self.contentLable.text = model.textStr;
    
    
    if (model.isSelectTed) {
        
//        self.backgroundColor = [UIColor yellowColor];
        
        self.contentLable.textColor = LYJTopSlideSelectColor;
        
        _contentLable.font = [UIFont systemFontOfSize:MasScale_1080(52)];
        
        
    }else{
        
//        self.backgroundColor = [UIColor whiteColor];
        
        self.contentLable.textColor = [UIColor blackColor];
    
    
         _contentLable.font = [UIFont systemFontOfSize:MasScale_1080(42)];
    }


}


#pragma mark - 类方法
+ (NSString *)registerCellID
{
    
    return CollectionCellId;
    
}

@end

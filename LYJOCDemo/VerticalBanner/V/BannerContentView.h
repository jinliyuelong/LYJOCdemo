//
//  bannerContentView.h
//  LYJOCDemo
//
//  Created by Liyanjun on 2017/3/10.
//  Copyright © 2017年 hand. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BannerContentViewDelegate;

@interface BannerContentView : UIView

@property (assign, nonatomic) NSInteger index;

@property(nonatomic, strong)UILabel* contentLable;//要显示的内容


@property (weak , nonatomic) id<BannerContentViewDelegate> bannerContentViewDelegate;

@end


@protocol BannerContentViewDelegate <NSObject>

- (void)didSelectedWithView:(UIView *)view pointFromWindow:(CGPoint)point row:(NSInteger)row;

@end

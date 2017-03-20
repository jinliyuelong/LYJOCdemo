//
//  VerticalBannerView.h
//  LYJOCDemo
//
//  Created by Liyanjun on 2017/3/10.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VerticalScrolDelegate;

@interface VerticalBannerView : UIView

@property (weak, nonatomic) id<VerticalScrolDelegate> scrolDelegate;


- (void)reloadData:(NSArray*)source;


@end

@protocol VerticalScrolDelegate <NSObject>

- (void)verticalBannerView:(VerticalBannerView *)scrol didSelectedImgWithRow:(NSInteger)row;

@end

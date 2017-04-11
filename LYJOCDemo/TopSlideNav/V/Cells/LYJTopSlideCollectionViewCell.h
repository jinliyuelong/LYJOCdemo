//
//  LYJTopSlideCollectionViewCell.h
//  LYJOCDemo
//
//  Created by Liyanjun on 2017/3/17.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYJTopSlideModel.h"

#define LYJTopSlideSelectColor    [UIColor redColor]//这里定义选中字体的颜色

@interface LYJTopSlideCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)UILabel *contentLable;//显示的lable



- (void)dataBind:(LYJTopSlideModel*)model;

+ (NSString *)registerCellID;
@end

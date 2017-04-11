//
//  LYJTopSlideNavView.h
//  LYJOCDemo
//
//  Created by Liyanjun on 2017/3/17.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYJTopSlideModel.h"

@interface LYJTopSlideNavView : UIView





- (void)dataBind:(NSMutableArray<LYJTopSlideModel*> *)dataSource;
@end

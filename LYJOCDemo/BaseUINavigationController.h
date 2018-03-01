//
//  BaseUINavigationController.h
//  LYJOCDemo
//
//  Created by Liyanjun on 2018/2/27.
//  Copyright © 2018年 liyanjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseUINavigationController : UINavigationController

+ (instancetype)navigationWithRootViewController:(UIViewController *)viewController;
@end

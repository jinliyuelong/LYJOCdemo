//
//  UIViewController+Extension.m
//  LYJOCDemo
//
//  Created by Liyanjun on 2017/3/2.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)





-(instancetype)initWithTitle:(NSString*)title{
    
    if (self=[super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.title=title;
    }
    return  self;
    
    
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end

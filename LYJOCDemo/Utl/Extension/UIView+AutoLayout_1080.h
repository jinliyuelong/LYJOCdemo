//
//  UIView+AutoLayout_1080.h
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/3/15.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

#import <UIKit/UIKit.h>

#define sizeScale_1080(s) (CGFloat)(([UIScreen mainScreen].bounds.size.width/1080.0)*(s)+0.5)

#define MasScale_1080(x)                         x*ScreenWidth/1080  //等比例获得数字


@interface UIView (AutoLayout_1080)


+ (CGFloat)getScale_height_1080:(CGFloat)height;
+ (CGFloat)getScale_width_1080:(CGFloat)width;

+ (CGPoint)getPoint_x_1080:(CGFloat)x y:(CGFloat)y;
+ (CGSize)getSize_width_1080:(CGFloat)width height:(CGFloat)height;
+ (CGRect)getFrame_x_1080:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height;

+ (CGPoint)getScalePoint_x_1080:(CGFloat)x y:(CGFloat)y;
+ (CGSize)getScaleSize_width_1080:(CGFloat)width height:(CGFloat)height;
+ (CGRect)getScaleFrame_x_1080:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height;

+ (void) setFrameToParentCenter_1080;
+ (void) setFrameHTOParentCenter_1080;
+ (void) setFrameVTOParentCenter_1080;
@end

//
//  UIView+AutoLayout_960.h
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/3/15.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

#import <UIKit/UIKit.h>

#define sizeScale_960(s) (CGFloat)(([UIScreen mainScreen].bounds.size.width/960.0)*(s)+0.5)

#define MasScale_960(x)                         x*ScreenWidth/960  //等比例获得数字


@interface UIView (AutoLayout_960)


+ (CGFloat)getScale_height_960:(CGFloat)height;
+ (CGFloat)getScale_width_960:(CGFloat)width;

+ (CGPoint)getPoint_x_960:(CGFloat)x y:(CGFloat)y;
+ (CGSize)getSize_width_960:(CGFloat)width height:(CGFloat)height;
+ (CGRect)getFrame_x_960:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height;

+ (CGPoint)getScalePoint_x_960:(CGFloat)x y:(CGFloat)y;
+ (CGSize)getScaleSize_width_960:(CGFloat)width height:(CGFloat)height;
+ (CGRect)getScaleFrame_x_960:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height;

+ (void) setFrameToParentCenter_960;
+ (void) setFrameHTOParentCenter_960;
+ (void) setFrameVTOParentCenter_960;
@end

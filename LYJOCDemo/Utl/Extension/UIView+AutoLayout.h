//
//  UIView+AutoLayout.h
//  JrLoanMobile
//
//  Created by song leilei on 15/12/8.
//  Copyright © 2015年 Junrongdai. All rights reserved.
//

#import <Foundation/Foundation.h>

#define sizeScale(s) (CGFloat)(([UIScreen mainScreen].bounds.size.width/320.0)*(s)+0.5)

#define MasScale(x)                         x*ScreenWidth/320  //等比例获得数字

@interface UIView (AutoLayout)

+ (CGFloat)getScale_height:(CGFloat)height;
+ (CGFloat)getScale_width:(CGFloat)width;

+ (CGPoint)getPoint_x:(CGFloat)x y:(CGFloat)y;
+ (CGSize)getSize_width:(CGFloat)width height:(CGFloat)height;
+ (CGRect)getFrame_x:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height;

+ (CGPoint)getScalePoint_x:(CGFloat)x y:(CGFloat)y;
+ (CGSize)getScaleSize_width:(CGFloat)width height:(CGFloat)height;
+ (CGRect)getScaleFrame_x:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height;

+ (void) setFrameToParentCenter;
+ (void) setFrameHTOParentCenter;
+ (void) setFrameVTOParentCenter;


@end

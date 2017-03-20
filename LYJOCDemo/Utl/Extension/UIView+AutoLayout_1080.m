//
//  UIView+AutoLayout_1080.m
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/3/15.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

#import "UIView+AutoLayout_1080.h"

@implementation UIView (AutoLayout_1080)



+(CGFloat)getScale_height_1080:(CGFloat)height{
    
    return height*ScreenWidth/1080;
}
+(CGFloat)getScale_width_1080:(CGFloat)width{
    
    return width*ScreenWidth/1080;
}

+ (CGPoint)getPoint_x_1080:(CGFloat)x y:(CGFloat)y{
    return CGPointMake(x, y);
}

+ (CGSize)getSize_width_1080:(CGFloat)width height:(CGFloat)height{
    return CGSizeMake(width, height);
}

+ (CGRect)getFrame_x_1080:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height{
    return CGRectMake(x, y, width, height);
}


+ (CGPoint)getScalePoint_x_1080:(CGFloat)x y:(CGFloat)y{
    x = x*ScreenWidth/1080;
    y = y*ScreenWidth/1080;
    return CGPointMake(x, y);
}

+ (CGSize)getScaleSize_width_1080:(CGFloat)width height:(CGFloat)height{
    
    width = width*ScreenWidth/1080;
    height = height*ScreenWidth/1080;
    
    return CGSizeMake(width, height);
}

+ (CGRect)getScaleFrame_x_1080:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height{
    
    x = x*ScreenWidth/1080;
    y = y*ScreenWidth/1080;
    width = width*ScreenWidth/1080;
    height = height*ScreenWidth/1080;
    
    return CGRectMake(x, y, width, height);
}

+ (void) setFrameToParentCenter_1080{
    
}

+ (void) setFrameHTOParentCenter_1080{
    
}

+ (void) setFrameVTOParentCenter_1080{
    
}

@end

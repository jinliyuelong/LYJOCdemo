//
//  UIView+AutoLayout_960.m
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/3/15.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

#import "UIView+AutoLayout_960.h"

@implementation UIView (AutoLayout_960)


+(CGFloat)getScale_height_960:(CGFloat)height{
    
    return height*ScreenWidth/960;
}
+(CGFloat)getScale_width_960:(CGFloat)width{
    
    return width*ScreenWidth/960;
}

+ (CGPoint)getPoint_x_960:(CGFloat)x y:(CGFloat)y{
    return CGPointMake(x, y);
}

+ (CGSize)getSize_width_960:(CGFloat)width height:(CGFloat)height{
    return CGSizeMake(width, height);
}

+ (CGRect)getFrame_x_960:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height{
    return CGRectMake(x, y, width, height);
}


+ (CGPoint)getScalePoint_x_960:(CGFloat)x y:(CGFloat)y{
    x = x*ScreenWidth/960;
    y = y*ScreenWidth/960;
    return CGPointMake(x, y);
}

+ (CGSize)getScaleSize_width_960:(CGFloat)width height:(CGFloat)height{
    
    width = width*ScreenWidth/960;
    height = height*ScreenWidth/960;
    
    return CGSizeMake(width, height);
}

+ (CGRect)getScaleFrame_x_960:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height{
    
    x = x*ScreenWidth/960;
    y = y*ScreenWidth/960;
    width = width*ScreenWidth/960;
    height = height*ScreenWidth/960;
    
    return CGRectMake(x, y, width, height);
}

+ (void) setFrameToParentCenter_960{
    
}

+ (void) setFrameHTOParentCenter_960{
    
}

+ (void) setFrameVTOParentCenter_960{
    
}

@end

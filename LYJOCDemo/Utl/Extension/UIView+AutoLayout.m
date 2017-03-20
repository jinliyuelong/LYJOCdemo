//
//  UIView+AutoLayout.m
//  JrLoanMobile
//
//  Created by song leilei on 15/12/8.
//  Copyright © 2015年 Junrongdai. All rights reserved.
//

#import "UIView+AutoLayout.h"

@implementation UIView (AutoLayout)

+(CGFloat)getScale_height:(CGFloat)height{
    
    return height*ScreenWidth/320;
}
+(CGFloat)getScale_width:(CGFloat)width{
    
    return width*ScreenWidth/320;
}

+ (CGPoint)getPoint_x:(CGFloat)x y:(CGFloat)y{
    return CGPointMake(x, y);
}

+ (CGSize)getSize_width:(CGFloat)width height:(CGFloat)height{
    return CGSizeMake(width, height);
}

+ (CGRect)getFrame_x:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height{
    return CGRectMake(x, y, width, height);
}


+ (CGPoint)getScalePoint_x:(CGFloat)x y:(CGFloat)y{
    x = x*ScreenWidth/320;
    y = y*ScreenWidth/320;
    return CGPointMake(x, y);
}

+ (CGSize)getScaleSize_width:(CGFloat)width height:(CGFloat)height{
    
    width = width*ScreenWidth/320;
    height = height*ScreenWidth/320;
    
    return CGSizeMake(width, height);
}

+ (CGRect)getScaleFrame_x:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height{
    
    x = x*ScreenWidth/320;
    y = y*ScreenWidth/320;
    width = width*ScreenWidth/320;
    height = height*ScreenWidth/320;
    
    return CGRectMake(x, y, width, height);
}

+ (void) setFrameToParentCenter{
    
}

+ (void) setFrameHTOParentCenter{
    
}

+ (void) setFrameVTOParentCenter{
    
}


@end

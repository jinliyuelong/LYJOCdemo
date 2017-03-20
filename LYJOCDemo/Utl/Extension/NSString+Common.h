//
//  NSString+trim.h
//  君融贷
//
//  Created by admin on 15/10/10.
//  Copyright (c) 2015年 JRD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Common)

//消除头尾的空格和换行
- (NSString *)trim;

- (BOOL)isEmpty;

- (NSString *)replaceUNumber;

- (NSString *)urlEncodedString;

- (NSString *)urlDecodedString;



//By李振华，计算文字高度的方法

/**
 *  根据一定宽度和字体计算高度
 *
 *  @param maxWith 最大宽度
 *  @param font  字体
 *
 *  @return 返回计算好高度的size
 */
- (CGSize)stringHeightWithMaxWidth:(CGFloat)maxWidth andFont:(UIFont*)font ;

/**
 *  根据一定高度和字体计算宽度
 *
 *  @param maxHeight 最大高度
 *  @param font      字体
 *
 *  @return 返回计算宽度的size
 */
- (CGSize)stringWidthWithMaxHeight:(CGFloat)maxHeight andFont:(UIFont*)font;

@end

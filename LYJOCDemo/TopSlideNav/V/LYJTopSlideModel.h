//
//  LYJTopSlideModel.h
//  LYJOCDemo
//
//  Created by Liyanjun on 2017/3/20.
//  Copyright © 2017年 liyanjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYJTopSlideModel : NSObject

@property (nonatomic, copy) NSString* textStr;///显示的标题

@property (nonatomic, assign) BOOL isSelectTed;//是否选中


- (instancetype)initWithtextStr:(NSString*)textStr isSelectTed:(BOOL) isSelectTed;

@end

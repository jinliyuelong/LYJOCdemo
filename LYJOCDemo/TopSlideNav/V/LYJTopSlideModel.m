//
//  LYJTopSlideModel.m
//  LYJOCDemo
//
//  Created by Liyanjun on 2017/3/20.
//  Copyright © 2017年 liyanjun. All rights reserved.
//

#import "LYJTopSlideModel.h"

@implementation LYJTopSlideModel


- (instancetype)initWithtextStr:(NSString*)textStr isSelectTed:(BOOL) isSelectTed
{
    self = [super init];
    if (self) {
        self.textStr = textStr;
        
        self.isSelectTed = isSelectTed;
    }
    return self;
}

@end

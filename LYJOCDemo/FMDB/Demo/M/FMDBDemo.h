//
//  FMDBDemo.h
//  LYJOCDemo
//
//  Created by Liyanjun on 2018/2/27.
//  Copyright © 2018年 liyanjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+TSStorageManager.h"

@interface FMDBDemo : NSObject
@property (nonatomic,strong) PrimaryKey * fmdbid;//主键
@property (nonatomic, assign)  BOOL  istrul;
@property (nonatomic, assign)  BOOL  istrul2;
@property (nonatomic, assign)  NSInteger  number1;
@property (nonatomic, assign)  float  number2;
@property (nonatomic, copy)  NSString * text1;
@property (nonatomic, copy)  NSString * text3;
@end

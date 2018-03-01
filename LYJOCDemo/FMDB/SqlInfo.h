//
//  SqlInfo.h
//  LittleSqlite
//
//  Created by liyanjun on 15/1/7.
//  Copyright (c) 2015年 liyanjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableInfo.h"

@interface SqlInfo : NSObject


@property(nonatomic,strong)  NSMutableDictionary * arguments;
@property(nonatomic,strong)  NSString * sql;
@property(nonatomic,strong) TableInfo * tableInfo;
@end

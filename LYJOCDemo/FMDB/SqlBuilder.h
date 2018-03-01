//
//  SqlBuilder.h
//  LittleSqlite
//
//  Created by liyanjun on 15/1/4.
//  Copyright (c) 2015年 liyanjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SqlInfo.h"
#import "TableInfo.h"

@interface SqlBuilder : NSObject



+(NSString *)buildCreatTableSql:(Class )class;


+(NSString *) buildDeleteSql :(Class )class;

+(SqlInfo *)buildInsertSql :(id) entity;

+(SqlInfo *)buildUpdateSql :(id) entity;

+(NSString *)buildQuerySql:(Class)class
columns:(NSArray*)columns;


+(NSString *)buildcreateIndexSql:(Class )class columns:(NSArray*)columns;


//添加新的字段
+(NSString *)buildAlterTable:(Class )class column:(NSString*)column;

@end

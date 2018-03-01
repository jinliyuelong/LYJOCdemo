//
//  TableInfo.h
//  LittleSqlite
//
//  Created by liyanjun on 15/1/6.
//  Copyright (c) 2015年 liyanjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableInfo : NSObject




+(instancetype) getTableInfo :(Class )class;

-(NSString *)getTableName;

-(NSMutableDictionary *)getPropertyMap;

-(NSString *)getPrimaryFieldName;

@end

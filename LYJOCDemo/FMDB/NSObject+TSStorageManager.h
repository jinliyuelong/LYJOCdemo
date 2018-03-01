//
//  NSObject+TSStorageManager.h
//  FrehsLink
//
//  Created by Liyanjun on 2017/10/23.
//  Copyright © 2017年 liyanjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnnotationType.h"

@interface NSObject (TSStorageManager)

/**
 *  创建表
 *
 *  
 */
-(void)creatTable;

//创建索引
-(BOOL)createIndex:(NSArray *)columns;

-(BOOL)insert;

- (BOOL)dropTable;
-(NSArray *)queryWithWhereStr:(NSString *)whereStr
                 orderBy:(NSString *)orderBy;

-(NSArray *)queryother:(NSString* )other WhereStr:(NSString *)whereStr
                      orderBy:(NSString *)orderBy otherquery:(NSString *)otherquery;

-(NSArray *)query:(NSArray *)columns
strWhere:(NSString *)strWhere
strOrderby:(NSString *)strOrderby;

-(BOOL)deleteWithWhereStr:(NSString *)whereStr;

-(BOOL)updateWithWhereStr:(NSString *)whereStr;
/**
 *  判断表是否存在
 *
 */
-(BOOL)isTableExists;


/**
 执行多个sql


 @param sqls 数组
 @return 返回是否成功
 */
-(BOOL) executeArraySqls:(NSArray*)sqls;

@end

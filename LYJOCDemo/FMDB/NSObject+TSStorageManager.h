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

@property (nonatomic,strong) PrimaryKey * fmdbid;//如果有主键，则创建主键，没有主键，则以这个为主键 需要

//返回主键名称，默认是fmdbid
+(NSString*)primaryKeyName;

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
 *  判断表是否存在,不存在则自动创建
 *
 */
-(void)checkTableExists;



/**
 执行多个sql
 
 
 @param sqls 数组
 @return 返回是否成功
 */
-(BOOL) executeArraySqls:(NSArray*)sqls;

// MARK:  返回插入语句的sqls
- (void)buildInsertSql:(NSObject* )obj sqls:(NSMutableArray*)sqls;

// MARK:  返回修改语句的sqls
- (void)buildUpdateSql:(NSObject* )obj sqls:(NSMutableArray*)sqls;

// MARK:  返回清空表语句的sqls
- (void)buildDeleteSql:(NSObject* )obj sqls:(NSMutableArray*)sqls;

// MARK:  返回创建索引语句的sqls
- (void)buildcreateIndexSql:(NSObject* )obj  columns:(NSArray*)columns sqls:(NSMutableArray*)sqls;


// MARK:  返回修改表语句的sqls
- (void)buildAlterTable:(NSObject* )obj  column:(NSString*)column sqls:(NSMutableArray*)sqls;


@end



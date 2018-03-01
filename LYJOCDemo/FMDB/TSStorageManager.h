//
//  TSStorageManager.h
//  Cetetek-Youyou
//
//  Created by liyanjun on 16-10-10.
//  Copyright (c) 2016年 cetetek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "SqlBuilder.h"
#import "FMDatabaseQueue.h"

#define DATABASE_FOLDER             @"database"
//#define DATABASE_NAME               @"HuiLianYiPlatform.db"

typedef enum {
    ORDER_BY_NONE = 0,
    ORDER_BY_DESC,
    ORDER_BY_ASC
} TS_ORDER_E;

#define IS_VALID_ORDER(e)  ((e) >= ORDER_BY_NONE && (e) <= ORDER_BY_ASC)

@interface TSStorageManager : NSObject
{
    FMDatabase *mDB;
}

@property (atomic, strong) FMDatabase *db;
@property (atomic, strong) FMDatabaseQueue *dbQueue;


+ (TSStorageManager *) sharedStorageManager;


/* CAUTION: only the UIApplication instance can invoke this method */
- (void)open;
/* CAUTION: only the UIApplication instance can invoke this method */
- (void)close;

// check whether we meet the error during database operation
- (void)checkError;
/*
 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 */

/**
 *  Description
 *
 *  @param entity 要保存的实例
 *
 *  @return true : 保存成功 ,false 保存失败
 */

-(BOOL)save:(id )entity;

-(BOOL)update:(id )entity;


-(BOOL)update:(id)entity
        where:(NSString *)strWhere;


-(NSArray *)query:(Class) class
columns:(NSArray *)columns
strWhere:(NSString *)strWhere
strOrderby:(NSString *)strOrderby;


-(NSArray *)query:(Class) class
others:(NSString *)others
strWhere:(NSString *)strWhere
strOrderby:(NSString *)strOrderby
otherquery:(NSString *)otherquery;

-(BOOL)createIndex:(Class) class
columns:(NSArray *)columns;

-(BOOL)delete:(Class)class;

-(BOOL)delete:(Class)class
where:(NSString *)strWhere;


-(NSError *)lastError;

-(BOOL)dropTable:(Class )class;


/**
 执行多个sql，只要有一个失败，执行回滚

 @param sqls 数组
 @return 返回是否成功
 */
-(BOOL) executeArraySqls:(NSArray*)sqls;

/**
 *  判断表是否存在，不存在将自动创建，若存在会继续判断有没有新增加的字段，如果有修改表
 *
 *  @param class
 */
-(void)checkTableExists:(Class )class;


/**
 *  判断表是否存在
 *
 *  @param class
 */
-(BOOL)isTableExists:(Class )class;

@end

//
//  NSObject+TSStorageManager.m
//  FrehsLink
//
//  Created by Liyanjun on 2017/10/23.
//  Copyright © 2017年 liyanjun. All rights reserved.
//

#import "NSObject+TSStorageManager.h"
#import "TSStorageManager.h"
#import <objc/runtime.h>

static const void *kName = "fmdbid";
@implementation NSObject (TSStorageManager)

#pragma mark - 字符串类型的动态绑定

- (PrimaryKey *)fmdbid{
    return objc_getAssociatedObject(self, kName);
}

- (void)setFmdbid:(PrimaryKey *)fmdbid{
    objc_setAssociatedObject(self, kName, fmdbid, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+(NSString*)primaryKeyName{
    return @"fmdbid";
}
/**
 *  判断表是否存在
 *
 */
-(BOOL)isTableExists{
    return [[TSStorageManager sharedStorageManager] isTableExists:[self class]];
}


-(void)checkTableExists{
    [[TSStorageManager sharedStorageManager] checkTableExists:[self class]];
}

-(BOOL) executeArraySqls:(NSArray*)sqls{
    
    return [[TSStorageManager sharedStorageManager] executeArraySqls:sqls];
}
-(void)creatTable{
    
    return [[TSStorageManager sharedStorageManager] checkTableExists:[self class]];
}
- (BOOL)dropTable{
    
    return [[TSStorageManager sharedStorageManager] dropTable:[self class]];
}


-(BOOL)insert
{
    
    
    TSStorageManager * _database  =  [TSStorageManager sharedStorageManager];
    return [_database save:self];
    
    
    
}


-(BOOL)deleteWithWhereStr:(NSString *)whereStr
{
    
    
    return    [[TSStorageManager sharedStorageManager] delete:[self class] where:whereStr];
    
    
}


-(BOOL)updateWithWhereStr:(NSString *)whereStr
{
    
    return    [[TSStorageManager sharedStorageManager] update:self where:whereStr];
    
}

-(NSArray *)query:(NSArray *)columns
         strWhere:(NSString *)strWhere
       strOrderby:(NSString *)strOrderby{
    
    return    [[TSStorageManager sharedStorageManager] query:[self class] columns:columns strWhere:strWhere strOrderby:strOrderby];
    
}

-(NSArray *)queryother:(NSString* )other WhereStr:(NSString *)whereStr
               orderBy:(NSString *)orderBy otherquery:(NSString *)otherquery{
    
    //    return
    return [[TSStorageManager sharedStorageManager] query:[self class] others:other strWhere:whereStr strOrderby:orderBy otherquery:otherquery];
    
}
-(NSArray *)queryWithWhereStr:(NSString *)whereStr
                      orderBy:(NSString *)orderBy
{
    
    
    return    [[TSStorageManager sharedStorageManager] query:[self class] columns:nil strWhere:whereStr strOrderby:orderBy];
    
}

-(BOOL)createIndex:(NSArray *)columns{
    
    return    [[TSStorageManager sharedStorageManager] createIndex:[self class] columns:columns];
}


// MARK:  返回插入语句的sqls
- (void)buildInsertSql:(NSObject* )obj sqls:(NSMutableArray*)sqls{
    SqlInfo* sql = [SqlBuilder buildInsertSql:obj];
    [sqls addObject:sql.sql];
    
    
}

// MARK:  返回修改语句的sqls
- (void)buildUpdateSql:(NSObject* )obj sqls:(NSMutableArray*)sqls{
    SqlInfo* sql = [SqlBuilder buildUpdateSql:obj];
    [sqls addObject:sql.sql];
    
    
}

// MARK:  返回清空表语句的sqls
- (void)buildDeleteSql:(NSObject* )obj sqls:(NSMutableArray*)sqls{
    [sqls addObject:[SqlBuilder buildDeleteSql:[obj class]]];
    
    
}

// MARK:  返回创建索引语句的sqls
- (void)buildcreateIndexSql:(NSObject* )obj  columns:(NSArray*)columns sqls:(NSMutableArray*)sqls{
    [sqls addObject:[SqlBuilder buildcreateIndexSql:[obj class] columns:columns]];
    
    
}


// MARK:  返回修改表语句的sqls
- (void)buildAlterTable:(NSObject* )obj  column:(NSString*)column sqls:(NSMutableArray*)sqls{
    [sqls addObject:[SqlBuilder buildAlterTable:[obj class] column:column]];
    
}


@end


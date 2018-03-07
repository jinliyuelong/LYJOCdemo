//
//  TSStorageManager.m
//  Cetetek-Youyou
//
//  Created by liyanjun on 16-10-10.
//  Copyright (c) 2016年 cetetek. All rights reserved.
//

#import "TSStorageManager.h"
#import "FMDatabase.h"
#import <objc/runtime.h>
#import "SqlBuilder.h"
#import "FMDatabaseAdditions.h" // 导入头文件
#import "NSString+Contain.h"


static TSStorageManager *sharedInstance = nil;

@interface TSStorageManager()



@end

@implementation TSStorageManager{
    NSError  * _lastError;
}

//@synthesize db = mDB;

+(TSStorageManager *) sharedStorageManager
{
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [[self alloc] init];
            return sharedInstance;
        }
    }
    
    return sharedInstance;
}

+(id) allocWithZone:(NSZone*)zone
{
    @synchronized(self)
    {
        if(sharedInstance ==nil) {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;
        }
    }
    return sharedInstance;
}

-(id) copyWithZone:(NSZone*)zone
{
    return self;
}


- (instancetype)init{
    @synchronized(self) {
        self = [super init];
        
        if(self){
            
            //        [self initialization];
        }
    }
    
    return self;
}



#pragma -mark ---------- Init Method -------------

- (void)open
{
    @synchronized(self) {
        NSFileManager *fm = [NSFileManager defaultManager];
        
        // create folder for database if needed
        NSString *dir = [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory,
                                                             NSUserDomainMask,
                                                             YES)
                         lastObject];
        NSString *dbfolder = [dir stringByAppendingPathComponent:DATABASE_FOLDER];
        
        NSLog(@"DBPath = %@",dbfolder);
        if (![fm fileExistsAtPath:dbfolder]) {
            NSLog(@"start to create database folder");
            NSError *error = nil;
            if (![fm createDirectoryAtPath:dbfolder withIntermediateDirectories:YES attributes:nil error:&error]) {
                NSLog(@"Ooops, cannot create database folder - %@", dbfolder);
                return;
            }
        }
        // create database if it does not exist
        
                NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        //        CFShow((__bridge CFTypeRef)(infoDictionary));
        // app名称
                NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
        
                NSString* daName = [NSString stringWithFormat:@"%@.db",app_Name];
        NSString* dbfile = [dbfolder stringByAppendingPathComponent:daName];
        
        self.db = [FMDatabase databaseWithPath:dbfile];
        self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbfile];
    }
}

- (void)close
{
    @synchronized(self) {
        //[self.db close];
    }
}


#pragma -mark ---------- DB operation Method -------------

-(BOOL) executeSQLUpdate:(NSString *) sqlStatement{
    
    
    NSLog(@"sqlStatement is %@ ",sqlStatement);
    
    __block BOOL result = NO;
    
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db open];
        result = [db executeUpdate:sqlStatement];
        _lastError = [db lastError];
        [db close];
    }];
    
    return result;
}


-(BOOL)executeArraySqls:(NSArray*)sqls{
    __block BOOL result = NO;
    
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db open];
        
        [db startSavePointWithName:@"tableError" error:nil];
        
        for (NSString* sql in sqls) {
            result = [db executeUpdate:sql withParameterDictionary:nil];
            if (!result) {
                break ;
            }
        }
        if (!result) {
            [db rollbackToSavePointWithName:@"tableError" error:nil];
        }
        [db releaseSavePointWithName:@"tableError" error:nil];
        _lastError = [db lastError];
        [db close];
    }];
    
    return result;
}
-(BOOL) executeSQLUpdate:(NSString *) sqlStatement param:(NSDictionary *)arguments{
    NSLog(@"sqlStatement is %@ ,arguments == %@",sqlStatement,arguments);
    __block BOOL result = NO;
    
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSLog(@"这里执行");
        [db open];
        result = [db executeUpdate:sqlStatement withParameterDictionary:arguments];
        _lastError = [db lastError];
        [db close];
    }];
    
    return result;
}

-(FMResultSet*) querySql:(NSString*)sql{
    
    __block FMResultSet *rs = nil;
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        
        rs = [db executeQuery:sql];
        
        [db close];
    }];
    
    return rs;
}



- (void)checkError{
    
    if ([self.db hadError]) {
        NSLog(@"!!!Database Error!!! %d: %@", [self.db lastErrorCode], [self.db lastErrorMessage]);
    }
}

#pragma mark  另外写的数据库操作


/**
 *  获取刚插入的主键id，如果返回－1则是没有
 *
 *  @param tableName
 */

-(NSNumber *)getLastInsertRowid:(NSString *)tableName
{
    
    NSString * querySql = [NSString stringWithFormat:@"select last_insert_rowid() lastId from %@",tableName];
    
    FMResultSet * resultSet =  [self querySql:querySql];
    
    NSNumber * lastId = [NSNumber numberWithInt:-1];
    
    if([resultSet next]){
        
        
        NSDictionary * result = [resultSet resultDictionary];
        lastId =  [result valueForKey:@"lastId"];
    }
    
    
    
    return lastId;
    
    
}


/**
 *  判断表是否存在，不存在将自动创建
 *
 *  @param class
 */
-(void)checkTableExists:(Class )class
{
    TableInfo * tableInfo =     [TableInfo getTableInfo:class];
    if(![self isTableOK :tableInfo.getTableName])
    {
        
        [self executeSQLUpdate:[SqlBuilder buildCreatTableSql:class]];
    }else{
        //判断有没有新增的字段
        NSMutableDictionary * propertys = tableInfo.getPropertyMap;
        NSEnumerator *enumerator = [propertys keyEnumerator];
        NSString * key;
        
        while ((key = [enumerator nextObject])) {
            if (![self istableExistColum:tableInfo.getTableName colum:key]) {
                NSString * type =  [propertys valueForKey:key];
                if([type myContainsString:@"NSNumber"] ||
                   [type myContainsString:@"NSData"] ||
                   [type myContainsString:@"TB"] ||
                   [type myContainsString:@"Tq"] ||
                   [type myContainsString:@"Tf"] ||
                   [type myContainsString:@"Td"] ||
                   [type myContainsString:@"NSString"]
                   ){
                    NSString * alterSql = [SqlBuilder buildAlterTable:class column:key];
                    [self executeSQLUpdate:alterSql param:nil];
                }
            }
            
        }
    }
    
    
}


/**
 *  判断表是否存在
 *
 *  @param class
 */
-(BOOL)isTableExists:(Class )class{
    TableInfo * tableInfo =     [TableInfo getTableInfo:class];
    return [self isTableOK :tableInfo.getTableName];
}
-(BOOL)save:(id)entity{
    
    BOOL result;
    
    [self checkTableExists:[entity class]];
    
    SqlInfo * info = [SqlBuilder buildInsertSql:entity];
    
    TableInfo * tableInfo = info.tableInfo;
    
    
    
    result = [self executeSQLUpdate:info.sql param:info.arguments];
    //
    //    if(result && tableInfo.getPrimaryFieldName !=nil ){
    //        NSNumber * lastId = [self getLastInsertRowid:tableInfo.getTableName];
    //
    //        [entity setValue:lastId forKey:tableInfo.getPrimaryFieldName];
    //    }
    
    return result;
    
}



-(BOOL)update:(id) entity
{
    
    return  [self update:entity where:nil];
}

-(BOOL)update:(id)entity
        where:(NSString *)strWhere
{
    SqlInfo * info = [SqlBuilder buildUpdateSql:entity];
    NSString * updateSql ;
    
    [self checkTableExists:[entity class]];
    
    if(strWhere == nil){
        
        strWhere = @"";
    }else {
        
        strWhere = [NSString stringWithFormat:@" where %@",strWhere];
    }
    
    updateSql =[info.sql stringByAppendingString:strWhere];
    
    
    
    
    return  [self executeSQLUpdate:updateSql param:info.arguments];
}


-(NSArray *)query:(Class) class
           others:(NSString *)others
         strWhere:(NSString *)strWhere
       strOrderby:(NSString *)strOrderby
       otherquery:(NSString *)otherquery{
    
    NSString * tableName = [NSString stringWithUTF8String:class_getName(class)];
    
    NSString * querySql = [NSString stringWithFormat:@"SELECT %@ FROM %@",others,tableName];
    
    NSMutableArray * results =[[NSMutableArray alloc] init];
    
    [self checkTableExists:class];
    if(strWhere != nil){
        querySql = [querySql stringByAppendingString:[@" where " stringByAppendingString:strWhere]];
    }
    
    if(strOrderby != nil){
        querySql =  [querySql stringByAppendingString:[@" order by " stringByAppendingString:strOrderby]];
    }
    
    if(otherquery != nil){
        querySql =  [querySql stringByAppendingString:[@" %@ " stringByAppendingString:otherquery]];
    }
    
    NSLog(@"querySql is %@",querySql);
    
    
    
    [self.dbQueue inDatabase:^(FMDatabase *db)   {
        [db open];
        FMResultSet *rs = [db executeQuery:querySql];
        while ([rs next]){
            NSDictionary * result = [rs resultDictionary];
            
            
            
            [results addObject:result];
        }
        [rs close];
        
        [db close];
    }];
    
    return  results;
    
    
}
-(NSArray *)query:(Class) class
          columns:(NSArray *)columns
         strWhere:(NSString *)strWhere
       strOrderby:(NSString *)strOrderby
{
    
    NSString * querySql = [SqlBuilder buildQuerySql:class columns:columns];
    NSMutableArray * results =[[NSMutableArray alloc] init];
    
    [self checkTableExists:class];
    
    if(strWhere != nil){
        querySql = [querySql stringByAppendingString:[@" where " stringByAppendingString:strWhere]];
    }
    
    if(strOrderby != nil){
        querySql =  [querySql stringByAppendingString:[@" order by " stringByAppendingString:strOrderby]];
    }
    
    
    NSLog(@"querySql is %@",querySql);
    
    
    
    
    [self.dbQueue inDatabase:^(FMDatabase *db)   {
        [db open];
        FMResultSet *rs = [db executeQuery:querySql];
        while ([rs next]){
            NSDictionary * result = [rs resultDictionary];
            
            
            id object = [[class alloc] init];
            [result enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                
                [object setValue:obj forKey:key];
                
            }];
            
            [results addObject:object];
        }
        [rs close];
        
        [db close];
    }];
    
    return  results;
    
    
    
}


-(BOOL)delete:(Class)class
{
    
    
    return [self delete:class where:nil];
}

-(BOOL)delete:(Class)class
        where:(NSString *)strWhere
{
    
    NSString * delSql ;
    
    [self checkTableExists:class];
    
    if(strWhere == nil){
        strWhere = @"";
    }else{
        strWhere =  [@" where " stringByAppendingString:strWhere];
    }
    
    delSql = [[SqlBuilder buildDeleteSql:class] stringByAppendingString:strWhere];
    
    
    
    
    return [self executeSQLUpdate:delSql param:nil];
    
    
    
}

-(BOOL)dropTable:(Class )class
{
    
    NSString * tableName = [NSString stringWithUTF8String:class_getName(class)];
    
    NSString * dropSql = [NSString stringWithFormat:@"drop table %@", tableName];
    
    return [self executeSQLUpdate:dropSql param:nil];
}

-(BOOL)createIndex:(Class) class
           columns:(NSArray *)columns{
    
    NSString * indexSql = [SqlBuilder buildcreateIndexSql:class columns:columns];
    
    [self checkTableExists:class];
    
    
    return  [self executeSQLUpdate:indexSql param:nil];
}

-(NSError *)lastError
{
    
    return _lastError;
}


- (BOOL)istableExistColum:(NSString *)tableName colum:(NSString*)colum{
    __block BOOL isExit = NO;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        isExit = [db columnExists:colum inTableWithName:tableName];
        [db close];
    }];
    return isExit;
}
- (BOOL) isTableOK:(NSString *)tableName{
    
    
    NSString *sql = [NSString stringWithFormat:@"select count(*) as 'count' from sqlite_master where type ='table' and name = '%@'",tableName];
    
    __block BOOL isExit = NO;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        FMResultSet *rs =[db executeQuery:sql];
        while ([rs next]){
            NSInteger count = [rs intForColumn:@"count"];
            if (0 == count){
                isExit = NO;
            }
            else{
                isExit = YES;
            }
        }
        
        [db close];
    }];
    return isExit;
}

@end


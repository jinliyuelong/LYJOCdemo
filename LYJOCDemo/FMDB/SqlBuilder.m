//
//  SqlBuilder.m
//  LittleSqlite
//
//  Created by liyanjun on 15/1/4.
//  Copyright (c) 2015年 liyanjun. All rights reserved.
//

#import "SqlBuilder.h"
#import <CoreData/CoreData.h>
#import <objc/runtime.h>

#import "NSString+Contain.h"



@implementation SqlBuilder


+(NSString *)buildQuerySql:(Class)class
                   columns:(NSArray*)columns
{
    NSString * querySql = @"select ";
    TableInfo * tableInf =  [TableInfo getTableInfo:class];
    
    
    if(columns != nil){
        
        for(int i=0;i< columns.count;i++)
        {
            
            querySql = [querySql stringByAppendingString:[columns objectAtIndex:i]];
            querySql = [querySql stringByAppendingString:@","];
            
            
        }
        
        querySql = [querySql  substringToIndex:[querySql length]-1];
        
        
    }else {
        
        
        querySql = [querySql stringByAppendingString:@" * "];
    }
    
    querySql =[querySql stringByAppendingString:@" from "];
    querySql =[querySql stringByAppendingString:tableInf.getTableName];
    
    
    
    return  querySql;
}


+(NSString *)buildcreateIndexSql:(Class )class columns:(NSArray*)columns{
    
    if (columns.count>0) {
        NSString * querySql = @"CREATE INDEX ";
        
        
        NSString *behindSql = @" ";
        
        
        TableInfo * tableInf =  [TableInfo getTableInfo:class];
        
        NSString* indexName = tableInf.getTableName;
        
        for(int i=0;i< columns.count;i++)
        {
            
            behindSql = [behindSql stringByAppendingString:[columns objectAtIndex:i]];
            behindSql = [behindSql stringByAppendingString:@","];
            indexName = [indexName stringByAppendingString:[columns objectAtIndex:i]];
            
        }
        
        behindSql = [behindSql  substringToIndex:[behindSql length]-1];
        
        
        querySql =[querySql stringByAppendingString:indexName];
        
        querySql =[querySql stringByAppendingString:@" ON "];
        querySql =[querySql stringByAppendingString: tableInf.getTableName];
        querySql =[querySql stringByAppendingString:@" ( "];
        querySql =[querySql stringByAppendingString:behindSql];
        
        querySql =[querySql stringByAppendingString:@" ) "];
        return  querySql;
        
    }else{
        return @"";
    }
    
    
}
+(NSString *)buildCreatTableSql:(Class )class
{
    TableInfo * tableInf =  [TableInfo getTableInfo:class];
    
    NSString * creatSql = @"CREATE TABLE IF NOT EXISTS  ";
    creatSql = [creatSql stringByAppendingString:tableInf.getTableName];
    creatSql = [creatSql stringByAppendingString:@"("];
    
    NSMutableDictionary * propertys = tableInf.getPropertyMap;
    
    
    NSEnumerator *enumerator = [propertys keyEnumerator];
    NSString * key;
    
    while ((key = [enumerator nextObject])) {
        
        NSString * type =  [propertys valueForKey:key];
        
        if([type myContainsString:@"NSNumber"] )
        {
            creatSql = [creatSql stringByAppendingString:key];
            
            creatSql  =  [creatSql stringByAppendingString:@"   INTEGER," ];
            
        }else if([type myContainsString:@"NSData"]){
            creatSql = [creatSql stringByAppendingString:key];
            creatSql  =  [creatSql stringByAppendingString:@"   BLOB," ];
            
        }else if([type myContainsString:@"TB"]){//bool
            creatSql = [creatSql stringByAppendingString:key];
            creatSql  =  [creatSql stringByAppendingString:@"   Boolean Default '0'," ];
            
        }else if([type myContainsString:@"Tq"]){//int
            creatSql = [creatSql stringByAppendingString:key];
            creatSql  =  [creatSql stringByAppendingString:@"   Integer," ];
            
        }else if([type myContainsString:@"Tf"]){//float
            creatSql = [creatSql stringByAppendingString:key];
            creatSql  =  [creatSql stringByAppendingString:@"   REAL," ];
            
        }else if([type myContainsString:@"Td"]){//double
            creatSql = [creatSql stringByAppendingString:key];
            creatSql  =  [creatSql stringByAppendingString:@"   Double," ];
            
        }else if([type myContainsString:@"NSString"]){
            creatSql = [creatSql stringByAppendingString:key];
            creatSql  =  [creatSql stringByAppendingString:@"   TEXT," ];
            
        }else if([type myContainsString:@"PrimaryKey"]){
            creatSql = [creatSql stringByAppendingString:key];
            
            creatSql  =  [creatSql stringByAppendingString:@"   INTEGER PRIMARY KEY AUTOINCREMENT," ];
            
        }else {
            
            @throw [[NSException alloc] initWithName:@"FMordException" reason:@"unsupport Member type" userInfo:nil];
            
        }
        
        
        
    }
    
    
    creatSql = [creatSql  substringToIndex:[creatSql length]-1];
    
    creatSql = [creatSql stringByAppendingString:@")"];
    
    return creatSql;
}


+(NSString *)buildAlterTable:(Class )class column:(NSString*)column{
    
    
    NSString * alterSql = @"ALTER TABLE ";
    
    
    
    TableInfo * tableInf =  [TableInfo getTableInfo:class];
    
    alterSql = [alterSql stringByAppendingString:tableInf.getTableName];
    alterSql = [alterSql stringByAppendingString:@" ADD "];

    NSMutableDictionary * propertys = tableInf.getPropertyMap;
    
    
    NSEnumerator *enumerator = [propertys keyEnumerator];
    NSString * key;
    
    while ((key = [enumerator nextObject])) {
        
        if ([key isEqualToString:column]) {
            NSString * type =  [propertys valueForKey:key];
            
            if([type myContainsString:@"NSNumber"] )
            {
                alterSql = [alterSql stringByAppendingString:key];
                
                alterSql  =  [alterSql stringByAppendingString:@"   INTEGER" ];
                
            }else if([type myContainsString:@"NSData"]){
                alterSql = [alterSql stringByAppendingString:key];
                alterSql  =  [alterSql stringByAppendingString:@"   BLOB" ];
                
            }else if([type myContainsString:@"TB"]){//bool
                alterSql = [alterSql stringByAppendingString:key];
                alterSql  =  [alterSql stringByAppendingString:@"   Boolean Default '0' " ];
                
            }else if([type myContainsString:@"Tq"]){//int
                alterSql = [alterSql stringByAppendingString:key];
                alterSql  =  [alterSql stringByAppendingString:@"   Integer" ];
                
            }else if([type myContainsString:@"Tf"]){//float
                alterSql = [alterSql stringByAppendingString:key];
                alterSql  =  [alterSql stringByAppendingString:@"   REAL" ];
                
            }else if([type myContainsString:@"Td"]){//double
                alterSql = [alterSql stringByAppendingString:key];
                alterSql  =  [alterSql stringByAppendingString:@"   Double" ];
                
            }else if([type myContainsString:@"NSString"]){
                alterSql = [alterSql stringByAppendingString:key];
                alterSql  =  [alterSql stringByAppendingString:@"   TEXT" ];
                
            }else {
                
                @throw [[NSException alloc] initWithName:@"FMordException" reason:@"unsupport Member type" userInfo:nil];
                
            }
        }
        
    }
    

    return  alterSql;
    
    
    
    
}

+(SqlInfo *)buildInsertSql :(id) entity
{
    
    TableInfo * tableInf =  [TableInfo getTableInfo:object_getClass(entity)];
    
    __block NSString * insertSql = @"INSERT INTO ";
    
    SqlInfo * sqlinfo = [[SqlInfo alloc] init];
    
    insertSql = [insertSql stringByAppendingString:tableInf.getTableName];
    
    insertSql = [insertSql stringByAppendingString:@"("];
    
    NSMutableDictionary * propertys = tableInf.getPropertyMap;
    
    
    NSEnumerator *enumerator = [propertys keyEnumerator];
    NSString * key;
    
    
    //这种方法enumerator 位置不会被重置
    while ((key = [enumerator nextObject])) {
        
        NSString * type =  [propertys valueForKey:key];
        
        id value  =  [entity valueForKey:key];
        
        //对空进行处理
        if(value != nil && ![type myContainsString:@"PrimaryKey"]){
            insertSql = [insertSql stringByAppendingString:key];
            insertSql = [insertSql stringByAppendingString:@","];
            [sqlinfo.arguments setValue:value forKey:key];
            
        }
    }
    
    insertSql = [insertSql  substringToIndex:[insertSql length]-1];
    insertSql = [insertSql stringByAppendingString:@") VALUES ( "];
    
    
    [propertys enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString * type =  [propertys valueForKey:key];
        id value  =  [entity valueForKey:key];
        
        if(value !=nil &&![type myContainsString:@"PrimaryKey"]){
            insertSql = [insertSql stringByAppendingString:@":"];
            insertSql = [insertSql stringByAppendingString:key];
            insertSql = [insertSql stringByAppendingString:@","];
        }
        
        
    }];
    
    
    insertSql = [insertSql  substringToIndex:[insertSql length]-1];
    insertSql = [insertSql stringByAppendingString:@")"];
    
    
    sqlinfo.sql = insertSql;
    sqlinfo.tableInfo = tableInf;
    
    return sqlinfo;
}




+(SqlInfo *)buildUpdateSql :(id) entity
{
    
    TableInfo * tableInf =  [TableInfo getTableInfo:object_getClass(entity)];
    
    NSMutableDictionary * propertys = tableInf.getPropertyMap;
    SqlInfo * sqlinfo = [[SqlInfo alloc] init];
    
    
    
    __block NSString * updateSql = @"UPDATE ";
    
    updateSql = [updateSql stringByAppendingString:tableInf.getTableName];
    updateSql = [updateSql stringByAppendingString:@"  set "];
    
    [propertys enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        NSString * type =  [propertys valueForKey:key];
        id value  =  [entity valueForKey:key];
        
        if(value == nil || [type myContainsString:@"PrimaryKey"]){
            
            
        }else {
            
            updateSql = [updateSql stringByAppendingFormat:@" %@ = :%@,",key,key];
            [sqlinfo.arguments setValue:value forKey:key];
            
        }
        
        
        
    }];
    
    updateSql = [updateSql  substringToIndex:[updateSql length]-1];
    
    
    sqlinfo.sql = updateSql;
    
    
    return sqlinfo;
    
}

+(NSString *) buildDeleteSql :(Class )class
{
    
    TableInfo * tableInf =  [TableInfo getTableInfo:class];
    
    NSString* delSql = @"DELETE FROM ";
    delSql  =  [delSql stringByAppendingString:[tableInf getTableName]];
    
    
    return delSql;
    
}


@end

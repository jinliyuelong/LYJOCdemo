//
//  NSObject+TSStorageManager.m
//  FrehsLink
//
//  Created by Liyanjun on 2017/10/23.
//  Copyright © 2017年 liyanjun. All rights reserved.
//

#import "NSObject+TSStorageManager.h"
#import "TSStorageManager.h"


@implementation NSObject (TSStorageManager)


/**
 *  判断表是否存在
 *
 */
-(BOOL)isTableExists{
     return [[TSStorageManager sharedStorageManager] isTableExists:[self class]];
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

@end

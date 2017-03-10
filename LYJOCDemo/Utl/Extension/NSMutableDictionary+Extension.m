//
//  NSMutableDictionary+Extension.m
//  LYJOCDemo
//
//  Created by Liyanjun on 2017/3/2.
//  Copyright © 2017年 hand. All rights reserved.
//

#import "NSMutableDictionary+Extension.h"

@implementation NSMutableDictionary (Extension)


- (void)setMyObject:(id)anObject forKey:(id)aKey
{
    
    
    if (anObject)
    {
        
        
        
        if (aKey) {
            
            [self setObject:anObject forKey:aKey];
            
        }
        else
        {
            
            // 要有一个断言
            
        }
        
        
    }
    else
    {
       
        
    }
    
    
}

- (id)myObjForKey:(id)aKey
{
    id aValue;
    
    
    aValue = [self objectForKey:aKey];
    
    if (aValue == nil || aValue == NULL || [aValue isEqualToString:@""])
    {
        
        // NSString *kong = @"NY";
        
        NSString *kong = @"";
        
        
        aValue = kong;
        
        
    }
    
    
    
    return aValue;
    
    
}


- (void)removeOneObjWithKey:(NSIndexPath *)indexPath cellCount:(NSInteger)cellCount
{
    
    // 这个逻辑 就是 每一个删除的 在删除那个点上移一个 obj
    
    // 用一个数组接受
    
    //  [self addEntriesFromDictionary:<#(nonnull NSDictionary *)#>];
    
    
    
    //indexPath.length
    
    
    // NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    //NSMutableArray *indexPathValue = [NSMutableArray array];
    
    NSMutableDictionary *indexPathValueDic = [NSMutableDictionary dictionary];
    
    
    // 这一部分去取出值
    
    [self enumerateKeysAndObjectsUsingBlock:^(NSIndexPath  * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        
        //NSLog(@"obj========asdasd====%@",obj);
        
        //NSLog(@"key==eeeeeee============%@",key);
        
        //NSLog(@"indexPath==fffff=========%@",indexPath);
        
        
        
        if (key.section == indexPath.section)
        {
            
            if (key.row > indexPath.row)
            {
                
                // 找到并且去掉了一个
                
                NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:key.row - 1 inSection:key.section];
                
                [indexPathValueDic setObject:newIndexPath forKey:obj];
                
                
                
            }
            
        }
        
        
    }];
    
    
    
    //NSLog(@"indexPathValueDic======11111====%@",indexPathValueDic);
    
    
    // 赋值
    
    [indexPathValueDic enumerateKeysAndObjectsUsingBlock:^(NSIndexPath * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        
        [self setObject:key forKey:obj];
        
    }];
    
    
    
    
    //
    
    
    
    
    
    
}

@end

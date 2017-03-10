//
//  NSMutableDictionary+Extension.h
//  LYJOCDemo
//
//  Created by Liyanjun on 2017/3/2.
//  Copyright © 2017年 hand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableDictionary (Extension)

// 给字典增加键值对 防止奔溃

- (void)setMyObject:(id)anObject forKey:(id)aKey;

// 这个就是 没有对应的nil 的时候就是“”

- (id)myObjForKey:(id)aKey;


// 这个方法就是找到 对应的section下面所有的值然后把它个 上移  就是 实现字典删除和 数字的删除类似的方法

- (void)removeOneObjWithKey:(NSIndexPath *)indexPath cellCount:(NSInteger)cellCount;


@end

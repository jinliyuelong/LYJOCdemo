//
//  AnnotationType.h
//  fmdb-orm
//
//  Created by liyanjun on 15/8/6.
//  Copyright (c) 2015年 liyanjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnnotationType : NSObject

@end

/**
 *  成员变量为primarykey类型，则框架自动解析为主键，自动增长
 */
@interface PrimaryKey : NSObject

@end

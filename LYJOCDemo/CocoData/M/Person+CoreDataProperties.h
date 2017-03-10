//
//  Person+CoreDataProperties.h
//  LYJOCDemo
//
//  Created by Liyanjun on 2017/3/3.
//  Copyright © 2017年 hand. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Person+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest;

@property (nonatomic) int16_t age;
@property (nullable, nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END

//
//  Person+CoreDataProperties.m
//  LYJOCDemo
//
//  Created by Liyanjun on 2017/3/3.
//  Copyright © 2017年 hand. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Person+CoreDataProperties.h"

@implementation Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Person"];
}

@dynamic age;
@dynamic name;

@end

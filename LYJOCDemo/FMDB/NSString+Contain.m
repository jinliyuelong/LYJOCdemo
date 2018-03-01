//
//  NSString+Contain.m
//  ALT399
//
//  Created by liyanjun on 15/12/28.
//  Copyright © 2015年 hand. All rights reserved.
//

#import "NSString+Contain.h"

@implementation NSString (Contain)

- (BOOL)myContainsString:(NSString*)other {
    NSRange range = [self rangeOfString:other];
    return range.length != 0;
}

@end

//
//  NSString+trim.m
//  君融贷
//
//  Created by admin on 15/10/10.
//  Copyright (c) 2015年 JRD. All rights reserved.
//

#import "NSString+Common.h"

@implementation NSString (Common)

//消除头尾的空格和换行
- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)isEmpty
{
    if ([self isKindOfClass:[NSString class]] && self.length > 0) {
        return NO;
    }
    
    return YES;
}

- (NSString*)replaceUNumber

{
    NSString *tempStr0 = [(NSString *)self stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    
    NSString *tempStr1 = [tempStr0 stringByReplacingOccurrencesOfString:@"\%u" withString:@"\\U"];
    
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                           
                                                           mutabilityOption:NSPropertyListImmutable
                           
                                                                     format:NULL
                           
                                                           errorDescription:NULL];
    
    
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
    
}

- (NSString *)urlEncodedString
{
    CFStringRef encodedCFString =
    CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)self,
                                            NULL,
                                            //                                            CFSTR("!*'();:@&=+$,/?%#[] "),
                                            CFSTR("?!@#$^&%*+,:;='\"`<>()[]{}/\\| "),
                                            kCFStringEncodingUTF8);
    NSString *encodedString = (NSString *)CFBridgingRelease(encodedCFString);
    NSString *result = @"";
    if (encodedCFString) {
        result = [[NSString alloc] initWithString:encodedString];
    }
    encodedCFString = nil;
    
    return result;
}

- (NSString*)urlDecodedString
{
    //    NSMutableString *outputStr = [NSMutableString stringWithString:self];
    //    [outputStr replaceOccurrencesOfString:@"+"
    //                               withString:@" "
    //                                  options:NSLiteralSearch
    //                                    range:NSMakeRange(0, [outputStr length])];
    //
    //    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    CFStringRef decodedCFString =
    CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                            (CFStringRef)self,
                                                            CFSTR(""),
                                                            kCFStringEncodingUTF8);
    
    NSString *decodedString = (NSString *)CFBridgingRelease(decodedCFString);
    NSString *result = @"";
    if (decodedString) {
        result = [[NSString alloc] initWithString:decodedString];
        result = [result stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    }
    
    return result;
}


- (CGSize)stringHeightWithMaxWidth:(CGFloat)maxWidth andFont:(UIFont*)font  {
    
    return  [self boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

- (CGSize)stringWidthWithMaxHeight:(CGFloat)maxHeight andFont:(UIFont*)font {
    
    return  [self boundingRectWithSize:CGSizeMake(MAXFLOAT, maxHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}
@end

//
//  NSData+AES256.h
//  迪信通Cloud
//
//  Created by user on 13-1-17.
//  Copyright (c) 2013年 eastedge. All rights reserved.
//



@interface NSData (AES256)
- (NSData *)AES256EncryptWithKey:(NSString *)key;//加密
- (NSData *)AES256DecryptWithKey:(NSString *)key;//解密
@end

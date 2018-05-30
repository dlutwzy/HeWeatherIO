//
//  MD5.m
//  NSString.MD5
//
//  Created by iMac on 2018/5/30.
//  Copyright © 2018年 iMac. All rights reserved.
//

#import "MD5.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation MD5
+ (NSData *)md5:(NSString *)str {
    
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH] = {0};
    CC_MD5(cStr, (CC_LONG)(strlen(cStr)), digest);
    return [NSData dataWithBytes:digest length:(NSUInteger)CC_MD5_DIGEST_LENGTH];
}
@end

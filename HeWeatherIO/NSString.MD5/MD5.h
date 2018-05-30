//
//  MD5.h
//  NSString.MD5
//
//  Created by iMac on 2018/5/30.
//  Copyright © 2018年 iMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MD5: NSObject
+ (NSData *)md5: (nonnull NSString *) str;
@end

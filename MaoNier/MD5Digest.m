//
//  MD5Digest.m
//  MaoNier
//
//  Created by dlut on 15/10/4.
//  Copyright (c) 2015年 dlut. All rights reserved.
//

#import "MD5Digest.h"
#import <CommonCrypto/CommonDigest.h>

@implementation MD5Digest

+ (NSString *)md5HexDigestWithTimeStamp:(NSString *)timeStamp token:(NSString *)token key:(NSString *)key {
    NSString *input = [[timeStamp stringByAppendingString:token] stringByAppendingString:key];
    const char *str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    NSMutableString *res = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [res appendFormat:@"%02x",result[i]];
    }
    return res;
}


@end

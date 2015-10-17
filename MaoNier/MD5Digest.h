//
//  MD5Digest.h
//  MaoNier
//
//  Created by dlut on 15/10/4.
//  Copyright (c) 2015年 dlut. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MD5Digest : NSObject
+ (NSString *)md5HexDigestWithTimeStamp:(NSString *)timeStamp token:(NSString *)token key:(NSString *)key;
@end

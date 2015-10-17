//
//  Message.h
//  MaoNier
//
//  Created by dlut on 15/9/29.
//  Copyright (c) 2015年 dlut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Remark.h"

@interface Message : Remark

@property(nonatomic, assign) float lat;
@property(nonatomic, assign) float lng;
@property(nonatomic, assign) UserSex sex;
@property(nonatomic, copy) NSString *token;
@property(nonatomic, copy) NSString *picUrl;
@property(nonatomic, copy) NSString *span;
@property(nonatomic, copy) NSString *location;
@property(nonatomic, assign) NSUInteger remarks;
@property(nonatomic, assign) NSUInteger likes;

- (instancetype)initWithID:(NSUInteger)ID content:(NSString *)content lat:(float)lat lng:(float)lng nick:(NSString *)nick sex:(UserSex)sex token:(NSString *)token span:(NSString *)span time:(NSString *)time location:(NSString *)location remarks:(NSUInteger)remarks likes:(NSUInteger)likes userID:(NSUInteger)userID;

@end

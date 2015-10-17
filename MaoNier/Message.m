//
//  Message.m
//  MaoNier
//
//  Created by dlut on 15/9/29.
//  Copyright (c) 2015年 dlut. All rights reserved.
//

#import "Message.h"

@implementation Message

- (instancetype)initWithID:(NSUInteger)ID content:(NSString *)content lat:(float)lat lng:(float)lng nick:(NSString *)nick sex:(UserSex)sex token:(NSString *)token span:(NSString *)span time:(NSString *)time location:(NSString *)location remarks:(NSUInteger)remarks likes:(NSUInteger)likes userID:(NSUInteger)userID {
    if (self = [super initWithID:ID content:content time:time nick:nick userID:userID]) {
        self.lat = lat;
        self.lng = lng;
        self.sex = sex;
        self.token = token;
        self.span = span;
        self.location = location;
        self.remarks = remarks;
        self.likes = likes;
    }
    return self;
}

@end

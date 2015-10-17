//
//  User.m
//  MaoNier
//
//  Created by dlut on 15/9/29.
//  Copyright (c) 2015年 dlut. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithID:(NSUInteger)ID token:(NSString *)token name:(NSString *)name psw:(NSString *)psw sex:(UserSex)sex {
    if (self = [super init]) {
        self.ID = ID;
        self.token = token;
        self.name = name;
        self.psw = psw;
        self.sex = sex;
    }
    return self;
}

@end

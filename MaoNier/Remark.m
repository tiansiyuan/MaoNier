//
//  Remark.m
//  MaoNier
//
//  Created by dlut on 15/9/29.
//  Copyright (c) 2015年 dlut. All rights reserved.
//

#import "Remark.h"

@implementation Remark

- (instancetype)initWithID:(NSUInteger)ID content:(NSString *)content time:(NSString *)time nick:(NSString *)nick userID:(NSUInteger)userID {
    if (self = [super init]) {
        self.ID = ID;
        self.content = content;
        self.time = time;
        self.nick = nick;
        self.userID = userID;
    }
    return self;
}

@end

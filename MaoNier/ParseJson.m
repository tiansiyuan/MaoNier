//
//  ParseJson.m
//  MaoNier
//
//  Created by dlut on 15/10/5.
//  Copyright (c) 2015年 dlut. All rights reserved.
//

#import "ParseJson.h"
#import "Message.h"
#import "User.h"

@implementation ParseJson

+ (void)parseWithMessages:(NSMutableArray *)messages dics:(NSArray *)dics {
    for (NSDictionary *dic in dics) {
        Message *message = [[Message alloc] init];
        [message setID:[dic[@"id"] intValue]];
        [message setContent:dic[@"content"]];
        [message setTime:dic[@"time"]];
        [message setNick:dic[@"nick"]];
        [message setUserID:[dic[@"hider_id"] intValue]];
        [message setLat:[dic[@"lat"] floatValue]];
        [message setLng:[dic[@"lng"] floatValue]];
        [message setToken:dic[@"name"]];
        [message setPicUrl:dic[@"url"]];
        [message setSpan:dic[@"span"]];
        [message setLocation:dic[@"city"]];
        [message setRemarks:[dic[@"remarks"] intValue]];
        [message setSex:UserSexFemale];
        [message setLikes:[dic[@"likes"] intValue]];
        [messages addObject:message];
    }
}

@end

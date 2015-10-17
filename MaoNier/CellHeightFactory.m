//
//  CellHeightFactory.m
//  MaoNier
//
//  Created by dlut on 15/10/5.
//  Copyright (c) 2015年 dlut. All rights reserved.
//

#define FONT_NAME @"Avenir-Book"
#define BOLD_FONT_NAME @"Avenir-Black"

#import "CellHeightFactory.h"
#import "MNPrefix.pch"
#import "Message.h"

@implementation CellHeightFactory

+ (CGFloat)measureHeightWithMessage:(Message *)message {
    CGFloat height = 0;
    UIFont *fontA = [UIFont fontWithName:BOLD_FONT_NAME size:18.0f];
    UIFont *fontB = [UIFont fontWithName:FONT_NAME size:17.0f];
    UIFont *fontC = [UIFont systemFontOfSize:15.0f];
    CGSize size = [message.nick sizeWithAttributes:@{NSFontAttributeName : fontA}];
    height += size.height;
    
    CGSize sizeContent = [message.content sizeWithAttributes:@{NSFontAttributeName : fontB}];
    CGFloat heightContent = 0;
    if (sizeContent.width <= SCREEN_WIDTH - 20) {
        heightContent = sizeContent.height * 1.2;
    }else {
        heightContent = ceil((sizeContent.width / (SCREEN_WIDTH - 20))) * sizeContent.height + 10;
    }
    
    height += (5 + heightContent);
    if (nil != message.picUrl && ![message.picUrl isKindOfClass:[NSNull class]] && ![message.picUrl isEqualToString:@"<null>"]) {
        height += 105;
    }
    CGSize sizeSpan = [message.span sizeWithAttributes:@{NSFontAttributeName : fontC}];
    height += (sizeSpan.height + 10);
    return height + 10;
}

@end

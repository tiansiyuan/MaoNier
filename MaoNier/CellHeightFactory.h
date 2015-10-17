//
//  CellHeightFactory.h
//  MaoNier
//
//  Created by dlut on 15/10/5.
//  Copyright (c) 2015年 dlut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Message;
@interface CellHeightFactory : NSObject

+ (CGFloat)measureHeightWithMessage:(Message *)message;

@end

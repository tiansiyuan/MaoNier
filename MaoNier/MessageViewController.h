//
//  MessageViewController.h
//  MaoNier
//
//  Created by dlut on 15/10/4.
//  Copyright (c) 2015年 dlut. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MessageViewControllerType) {
    MessageViewControllerTypeNear,
    MessageViewControllerTypeHot
};

@interface MessageViewController : UITableViewController

- (instancetype)initWithType:(MessageViewControllerType)type;

@end

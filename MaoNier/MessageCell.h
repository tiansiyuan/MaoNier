//
//  MessageCell.h
//  MaoNier
//
//  Created by dlut on 15/9/29.
//  Copyright (c) 2015年 dlut. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Message;
@interface MessageCell : UITableViewCell

@property(nonatomic, strong) UILabel *nick;
@property(nonatomic, strong) UIImageView *sex;
@property(nonatomic, strong) UILabel *content;
@property(nonatomic, strong) UIImageView *picImageView;
@property(nonatomic, strong) UILabel *span;
@property(nonatomic, strong) UILabel *time;
@property(nonatomic, strong) UILabel *location;
@property(nonatomic, strong) UILabel *reply;
@property(nonatomic, strong) UILabel *like;

- (void)layoutCellWithMessage:(Message *)message;

@end

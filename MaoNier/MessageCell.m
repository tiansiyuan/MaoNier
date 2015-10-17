//
//  MessageCell.m
//  MaoNier
//
//  Created by dlut on 15/9/29.
//  Copyright (c) 2015年 dlut. All rights reserved.
//

#define FONT_NAME @"Avenir-Book"
#define BOLD_FONT_NAME @"Avenir-Black"

#import "MessageCell.h"
#import "Message.h"
#import "MNPrefix.pch"
#import "User.h"
#import "UIImageView+PINRemoteImage.h"

@implementation MessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.nick = [[UILabel alloc] initWithFrame:CGRectZero];
        self.sex = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.content = [[UILabel alloc] initWithFrame:CGRectZero];
        self.picImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.span = [[UILabel alloc] initWithFrame:CGRectZero];
        self.time = [[UILabel alloc] initWithFrame:CGRectZero];
        self.location = [[UILabel alloc] initWithFrame:CGRectZero];
        self.reply = [[UILabel alloc] initWithFrame:CGRectZero];
        self.like = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:self.nick];
        [self.contentView addSubview:self.sex];
        [self.contentView addSubview:self.content];
        [self.contentView addSubview:self.picImageView];
        [self.contentView addSubview:self.span];
        [self.contentView addSubview:self.time];
        [self.contentView addSubview:self.location];
        [self.contentView addSubview:self.reply];
        [self.contentView addSubview:self.like];
    }
    return self;
}

- (void)layoutCellWithMessage:(Message *)message {
    CGFloat height = 0;
    UIFont *fontA = [UIFont fontWithName:BOLD_FONT_NAME size:18.0f];
    UIFont *fontB = [UIFont fontWithName:FONT_NAME size:17.0f];
    UIFont *fontC = [UIFont systemFontOfSize:15.0f];
    
    CGSize size = [message.nick sizeWithAttributes:@{NSFontAttributeName : fontA}];
    [self.nick setFrame:CGRectMake((SCREEN_WIDTH - size.width) / 2, 6, size.width, size.height)];
    [self.nick setText:message.nick];
    
    height += size.height;
    [self.sex setFrame:CGRectMake(CGRectGetMaxX(self.nick.frame) + 10, 6 + size.height / 2 - 16 / 2, 16, 16)];
    if (message.sex == UserSexFemale) {
        [self.sex setImage:[UIImage imageNamed:@"star.png"]];
    }else if (message.sex == UserSexMale) {
        [self.sex setImage:[UIImage imageNamed:@"star.png"]];
    }else {
        
    }
    
    CGSize sizeContent = [message.content sizeWithAttributes:@{NSFontAttributeName : fontB}];
    CGFloat heightContent = 0;
    if (sizeContent.width <= SCREEN_WIDTH - 20) {
        heightContent = sizeContent.height * 1.2;
    }else {
        heightContent = ceil((sizeContent.width / (SCREEN_WIDTH - 20))) * sizeContent.height + 10;
    }
    [self.content setFrame:CGRectMake(10, height + 8, SCREEN_WIDTH - 20, heightContent)];
    [self.content setLineBreakMode:NSLineBreakByCharWrapping];
    [self.content setNumberOfLines:0];
    [self.content setText:message.content];
    [self.content setFont:fontB];
    
    height += (5 + heightContent);
    if (nil != message.picUrl && ![message.picUrl isKindOfClass:[NSNull class]] && ![message.picUrl isEqualToString:@"<null>"]) {
        [self.picImageView pin_setImageFromURL:[NSURL URLWithString:[PICS_ROOT_URL stringByAppendingString:message.picUrl]] placeholderImage:[UIImage imageNamed:@"maoni.png"]
         ];
        [self.picImageView setFrame:CGRectMake(10, height + 5, 100, 100)];
        [self.picImageView setClipsToBounds:YES];
        [self.picImageView setHidden:NO];
        height += 105;
    }else {
        [self.picImageView setHidden:YES];
    }
    
    CGSize sizeSpan = [message.span sizeWithAttributes:@{NSFontAttributeName : fontC}];
    [self.span setFrame:CGRectMake(10, height + 5, sizeSpan.width, sizeSpan.height)];
    [self.span setText:message.span];
    [self.span setFont:fontC];
    
    CGSize sizeTime = [message.time sizeWithAttributes:@{NSFontAttributeName : fontC}];
    [self.time setFrame:CGRectMake(CGRectGetMaxX(self.span.frame) + 5, height + 5, sizeTime.width, sizeTime.height)];
    [self.time setText:message.time];
    [self.time setFont:fontC];
    
    CGSize sizeLocation = [message.location sizeWithAttributes:@{NSFontAttributeName : fontC}];
    [self.location setFrame:CGRectMake(CGRectGetMaxX(self.time.frame) + 5, height + 5, sizeLocation.width, sizeLocation.height)];
    [self.location setText:message.location];
    [self.location setFont:fontC];
    
    NSString *likes = [NSString stringWithFormat:@"赞 %lu",message.likes];
    CGSize sizeLike = [likes sizeWithAttributes:@{NSFontAttributeName : fontC}];
    [self.like setFrame:CGRectMake(SCREEN_WIDTH - 8 - sizeLike.width, height + 5, sizeLike.width, sizeLike.height)];
    [self.like setText:likes];
    [self.like setFont:fontC];
    
    NSString *remarks = [NSString stringWithFormat:@"评论 %lu", (unsigned long)(message.remarks)];
    CGSize sizeRemark = [remarks sizeWithAttributes:@{NSFontAttributeName : fontC}];
    [self.reply setFrame:CGRectMake(CGRectGetMinX(self.like.frame) - 15 - sizeRemark.width, height + 5, sizeRemark.width, sizeRemark.height)];
    [self.reply setText:remarks];
    [self.reply setFont:fontC];
    
    height += sizeLike.height + 10;
    [self setFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

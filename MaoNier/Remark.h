//
//  Remark.h
//  MaoNier
//
//  Created by dlut on 15/9/29.
//  Copyright (c) 2015年 dlut. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Remark : NSObject

@property(nonatomic, assign) NSUInteger ID;
@property(nonatomic, copy) NSString *content;
@property(nonatomic, copy) NSString *time;
@property(nonatomic, copy) NSString *nick;
@property(nonatomic, assign) NSUInteger userID;

- (instancetype)initWithID:(NSUInteger)ID content:(NSString *)content time:(NSString *)time nick:(NSString *)nick userID:(NSUInteger)userID;

@end

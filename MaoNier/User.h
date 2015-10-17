//
//  User.h
//  MaoNier
//
//  Created by dlut on 15/9/29.
//  Copyright (c) 2015年 dlut. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, UserSex){
    UserSexNone = 0,
    UserSexMale,
    UserSexFemale
};

@interface User : NSObject

@property(nonatomic, assign) NSUInteger ID;
@property(nonatomic, copy) NSString *token;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *psw;
@property(nonatomic, assign) UserSex sex;
@property(nonatomic, assign) float lat;
@property(nonatomic, assign) float lng;
@property(nonatomic, copy) NSString *province;
@property(nonatomic, copy) NSString *city;
@property(nonatomic, copy) NSString *district;

- (instancetype)initWithID:(NSUInteger)ID token:(NSString *)token name:(NSString *)name psw:(NSString *)psw sex:(UserSex)sex;

@end

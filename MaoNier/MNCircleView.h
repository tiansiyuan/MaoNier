//
//  MNCircleView.h
//  MaoNier
//
//  Created by dlut on 15/10/16.
//  Copyright (c) 2015年 dlut. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CircleViewClickBlock)(NSUInteger);

@class MNCircleView;
@protocol MNCircleViewDelegate <NSObject>
@optional
- (void)circleViewDidSelectedImage:(MNCircleView *)circleView index:(NSUInteger)index;
@end

@interface MNCircleView : UIView
@property(nonatomic, assign) id<MNCircleViewDelegate> delegate;
@property(nonatomic, copy) NSArray *images;
@property(nonatomic, assign) BOOL aotoPlay;
@property(nonatomic, assign) NSTimeInterval timeInterval;
@property(nonatomic, copy) CircleViewClickBlock circleViewClickBlock;

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray*)images aotoPlay:(BOOL)aotoPlay timeInterval:(NSTimeInterval)timeInterval;
@end

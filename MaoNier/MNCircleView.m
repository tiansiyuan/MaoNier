//
//  MNCircleView.m
//  MaoNier
//
//  Created by dlut on 15/10/16.
//  Copyright (c) 2015年 dlut. All rights reserved.
//

#import "MNCircleView.h"
#import "MNPrefix.pch"

@interface MNCircleView() <UIScrollViewDelegate>
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, assign) NSUInteger currentPage;
@property(nonatomic, strong) NSMutableArray *imagesArray;
@property(nonatomic, strong) UIPageControl *pageControl;
@end

@implementation MNCircleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray*)images aotoPlay:(BOOL)aotoPlay timeInterval:(NSTimeInterval)timeInterval {
    if (self = [super initWithFrame:frame]) {
        self.images = images;
        self.aotoPlay = aotoPlay;
        self.timeInterval = timeInterval;
        self.currentPage = 0;
        [self addScrollView];
        [self addPageControl];
        [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(aotoPlaying) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)addScrollView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    for (NSUInteger i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, self.bounds.size.height)];
        [imageView setImage:[UIImage imageNamed:self.imagesArray[i]]];
        [self.scrollView addSubview:imageView];
    }
    [self addSubview:self.scrollView];
    [self.scrollView setContentSize:CGSizeMake(SCREEN_WIDTH * 3, self.bounds.size.height)];
    [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0)];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    [self.scrollView setDelegate:self];
    [self.scrollView setPagingEnabled:YES];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)];
    [self.scrollView addGestureRecognizer:gesture];
}

- (void)addPageControl {
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    [self.pageControl setNumberOfPages:[self.images count]];
    [self.pageControl setCurrentPage:0];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 20, SCREEN_WIDTH, 20)];
    [view setBackgroundColor:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.2]];
    [view addSubview:self.pageControl];
    [self addSubview:view];
}

- (NSMutableArray *)imagesArray {
    if (nil == _imagesArray) {
        self.imagesArray = [[NSMutableArray alloc] initWithCapacity:3];
    }
    [_imagesArray removeAllObjects];
    NSUInteger count = [self.images count];
    NSUInteger left = (self.currentPage + count - 1) % count;
    [_imagesArray addObject:self.images[left]];
    [_imagesArray addObject:self.images[self.currentPage]];
    NSUInteger right = (self.currentPage + count + 1) % count;
    [_imagesArray addObject:self.images[right]];
    return _imagesArray;
}

- (void)imageClick {
    if ([self.delegate respondsToSelector:@selector(circleViewDidSelectedImage:index:)]) {
        [self.delegate circleViewDidSelectedImage:self index:self.currentPage];
    }else if (nil != self.circleViewClickBlock) {
        self.circleViewClickBlock(self.currentPage);
    }
}

- (void)refreshImages {
    NSArray *subviews = self.scrollView.subviews;
    NSUInteger i = 0;
    for (UIView *view in subviews) {
        UIImageView *imageView = (UIImageView *)view;
        [imageView setImage:[UIImage imageNamed:self.imagesArray[i++]]];
    }
    [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0)];
}

- (void)aotoPlaying {
    [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * 2, 0) animated:YES];
}

#pragma UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat x = scrollView.contentOffset.x;
    if (x >= 2 * SCREEN_WIDTH) {
        self.currentPage = (self.currentPage + 1) % [self.images count];
        [self refreshImages];
        [self.pageControl setCurrentPage:self.currentPage];
    }
    if (x <= 0) {
        self.currentPage = (self.currentPage - 1 + [self.images count]) % [self.images count];
        [self refreshImages];
        [self.pageControl setCurrentPage:self.currentPage];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
}

@end

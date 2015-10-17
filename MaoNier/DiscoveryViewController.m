//
//  DiscoveryViewController.m
//  MaoNier
//
//  Created by dlut on 15/9/26.
//  Copyright (c) 2015年 dlut. All rights reserved.
//

#define SEGMENTCONTROL_DEFAULT_WIDTH 72

#import "DiscoveryViewController.h"
#import "ViewController.h"
#import "MessageViewController.h"

@interface DiscoveryViewController (){
    BOOL _rightClick;
}

@property(nonatomic, strong) MessageViewController *nearViewController;
@property(nonatomic, strong) MessageViewController *hotViewController;
@property(nonatomic, assign) NSUInteger currentIndex;
@property(nonatomic, assign) UITableViewController *currentTableViewController;
@property(nonatomic, assign) BOOL isFirst;

@end

@implementation DiscoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *leftBarBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"地图" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarClick)];
    [self.navigationItem setLeftBarButtonItem:leftBarBtnItem];
    
    UIBarButtonItem *rightbarBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"秘密" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarClick)];
    [self.navigationItem setRightBarButtonItem:rightbarBtnItem];
    
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"附近", @"热门"]];
    [segmentControl addTarget:self action:@selector(segmentControlChange:) forControlEvents:UIControlEventValueChanged];
    [segmentControl addTarget:self action:@selector(leftBarClick) forControlEvents:UIControlEventValueChanged];
    [segmentControl setSelectedSegmentIndex:0];
    [segmentControl setWidth:SEGMENTCONTROL_DEFAULT_WIDTH forSegmentAtIndex:0];
    [segmentControl setWidth:SEGMENTCONTROL_DEFAULT_WIDTH forSegmentAtIndex:1];
    [self.navigationItem setTitleView:segmentControl];
    
    _rightClick = NO;
    
    self.nearViewController = [[MessageViewController alloc] initWithType:MessageViewControllerTypeNear];
    [self addChildViewController:self.nearViewController];
    [self.view addSubview:self.nearViewController.view];
    [self.nearViewController beginAppearanceTransition:YES animated:YES];
    self.isFirst = YES;
    _rightClick = NO;
}

- (void)leftBarClick {
    NSLog(@"You clicked leftBarBtnItem!");
}

- (MessageViewController *)hotViewController {
    if (nil == _hotViewController) {
        self.hotViewController = [[MessageViewController alloc] initWithType:MessageViewControllerTypeHot];
    }
    return _hotViewController;
}

- (void)segmentChangeAtIndex:(NSUInteger)index {
    if (index == self.currentIndex) {
        return;
    }
    if (index == 0) {
        [self transitionFromViewController:self.hotViewController toViewController:self.nearViewController duration:1.0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
            
        } completion:^(BOOL finished) {
            self.currentIndex = index;
        }];
    }else if (index == 1) {
        if (self.isFirst) {
            [self addChildViewController:self.hotViewController];
            self.isFirst = NO;
        }
        [self transitionFromViewController:self.nearViewController toViewController:self.hotViewController duration:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
            
        } completion:^(BOOL finished) {
            self.currentIndex = index;
        }];
    }
}

- (void)segmentControlChange:(id)sender {
    switch ([sender selectedSegmentIndex]) {
        case 0:
            [self segmentChangeAtIndex:0];
            break;
        case 1:
            [self segmentChangeAtIndex:1];
            break;
        default:
            break;
    }
}

- (void)rightBarClick {
    ViewController *viewController = [[ViewController alloc] init];
    [viewController.view setBackgroundColor:[UIColor redColor]];
    _rightClick = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    if (_rightClick) {
        [self.tabBarController.tabBar setHidden:YES];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    _rightClick = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  WebViewController.m
//  MaoNier
//
//  Created by dlut on 15/10/10.
//  Copyright (c) 2015年 dlut. All rights reserved.
//

#import "WebViewController.h"
#import "MNPrefix.pch"
#import "MNCircleView.h"

@interface WebViewController () <MNCircleViewDelegate>
@property(nonatomic, strong) UIWebView *webView;
@property(nonatomic, strong) NSArray *array;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    [self.view addSubview:self.webView];
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://202.118.67.200:10717/2015/"]]];
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"caodi" ofType:@"html"]]]];
//    [self.webView setDelegate:self];
//    NSMutableArray *mArray = [[NSMutableArray alloc] init];
//    self.array = mArray;
//    [mArray addObject:@"hello world"];
//    NSLog(@"%@", [self.array objectAtIndex:0]);
    [self.view setBackgroundColor:[UIColor orangeColor]];
    NSArray *array = [NSArray arrayWithObjects:@"zoro.jpg", @"onepiece.jpg", @"three.jpg", nil];
    NSLog(@"count array is %lu", [array count]);
    MNCircleView *circleView = [[MNCircleView alloc] initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, SCREEN_HEIGHT / 4) images:array aotoPlay:YES timeInterval:6.5];
    [self.view addSubview:circleView];
//    [circleView setDelegate:self];
    [circleView setCircleViewClickBlock:^(NSUInteger index) {
        NSLog(@"you clicked index %lu", index);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"start load webview");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"finish laod webView");
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"url is %@, %@", request.URL.absoluteString, request.URL.relativeString);
    return YES;
}

#pragma MNCircleViewdelegate
- (void)circleViewDidSelectedImage:(MNCircleView *)circleView index:(NSUInteger)index {
    NSLog(@"you click NO.%lu image", index);
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

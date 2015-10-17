//
//  MessageViewController.m
//  MaoNier
//
//  Created by dlut on 15/10/4.
//  Copyright (c) 2015年 dlut. All rights reserved.
//

#import "MessageViewController.h"
#import "MNPrefix.pch"
#import "MessageCell.h"
#import "Message.h"
#import "MJRefresh.h"
#import "MD5Digest.h"
#import "AFNetworking.h"
#import "ParseJson.h"
#import "CellHeightFactory.h"

@interface MessageViewController ()
@property(nonatomic, assign) MessageViewControllerType type;
@property(nonatomic, copy) NSString *msgUrl;
@property(nonatomic, strong) NSMutableArray *messages;
@property(nonatomic, assign) NSUInteger pageNum;
@property(nonatomic, strong) AFHTTPRequestOperationManager *manager;
@property(nonatomic, assign) NSUInteger lastMsgID;
@property(nonatomic, strong) NSMutableDictionary *cellHeightCache;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.type == MessageViewControllerTypeNear) {
        self.msgUrl = [ROOT_URL stringByAppendingString:NEAR_MESSAGE_URL];
    }else if (self.type == MessageViewControllerTypeHot){
        self.msgUrl = [ROOT_URL stringByAppendingString:HOT_MESSAGE_URL];
    }
    self.messages = [[NSMutableArray alloc] init];
    [self.messages addObject:[[Message alloc] initWithID:123 content:@"hello aaaaaa" lat:123 lng:123 nick:@"grace" sex:UserSexFemale token:@"" span:@"123mi" time:@"1h" location:@"beijing" remarks:123 likes:12 userID:12]];
    [self.messages addObject:[[Message alloc] initWithID:123 content:@"hello aaaaaa hahhahahahha" lat:123 lng:123 nick:@"grace" sex:UserSexFemale token:@"" span:@"123mim" time:@"1h" location:@"beijing" remarks:123 likes:12 userID:12]];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
//    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    if (self.type == MessageViewControllerTypeHot) {
        [self.tableView setFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self.tableView setBackgroundColor:[UIColor purpleColor]];
    }else {
        [self.tableView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    [self.tableView setHeader:[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)]];
    [self.tableView setFooter:[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)]];
//    [self.tableView setFooter:[MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)]];
    
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    self.pageNum = 0;
    self.lastMsgID = -1;
//    [self refreshData];
    self.cellHeightCache = [[NSMutableDictionary alloc] init];
}

- (void)refreshData {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self fetchDataFromServer:NO];
}

-(void)loadMoreData {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self fetchDataFromServer:YES];
}

- (void)fetchDataFromServer:(BOOL)isLoadMore {
    NSNumber *timeStamp = [NSNumber numberWithLong:time(NULL)];
    NSDictionary *params = @{
                             @"time" : timeStamp,
                             @"content" : MD5_TOKEN,
                             @"pageSize" : @10,
                             @"type" : @"near",
                             @"pageNum" : [NSNumber numberWithUnsignedInteger:self.pageNum],
                             @"lat" : [NSNumber numberWithFloat:38.880],
                             @"lng" : [NSNumber numberWithFloat:121.548],
                             @"key" : [MD5Digest md5HexDigestWithTimeStamp:[timeStamp stringValue] token:MD5_TOKEN key:MD5_KEY]
                             };
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];
    if (self.type == MessageViewControllerTypeHot) {
        paramsDic[@"pageSize"] = @"16";
    }
    if (isLoadMore) {
        paramsDic[@"pageNum"] = [NSString stringWithFormat:@"%lu",self.pageNum + 1];
        if (self.lastMsgID > 0) {
            paramsDic[@"start"] = [NSNumber numberWithLong:self.lastMsgID];
        }
    }else {
        paramsDic[@"pageNum"] = @0;
    }
    [self.manager POST:self.msgUrl parameters:paramsDic success:^(AFHTTPRequestOperation * operation, id responseObject) {
        NSInteger code = [responseObject[@"code"] integerValue];
        if (1 == code) {
            NSArray *dics = responseObject[@"result"];
            if ([dics count] > 0) {
                if (isLoadMore) {
                    ++self.pageNum;
                }else {
                    self.pageNum = 0;
                    [self.messages removeAllObjects];
                }
                [ParseJson parseWithMessages:self.messages dics:dics];
                self.lastMsgID = [(Message *)[self.messages lastObject] ID];
            }
        }
        [self afterLoad];
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        [self afterLoad];
    }];
}

- (void)afterLoad {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)initWithType:(MessageViewControllerType)type {
    if (self = [super init]) {
        self.type = type;
    }
    return self;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    NSString *key = [NSString stringWithFormat:@"message_cell%ld",[indexPath row]];
    id value = [self.cellHeightCache objectForKey:key];
    if (value != nil) {
        height = [value floatValue];
    }else {
        height = [CellHeightFactory measureHeightWithMessage:self.messages[[indexPath row]]];
        [self.cellHeightCache setObject:[NSNumber numberWithFloat:height] forKey:key];
    }
    return height;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCell *cell;
    if (self.type == MessageViewControllerTypeNear) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"message_near"];
        if (nil == cell) {
            cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"message_near"];
        }
    }else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"message_hot"];
        if (nil == cell) {
            cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"message_hot"];
        }
    }
    [cell layoutCellWithMessage:[self.messages objectAtIndex:indexPath.row]];
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

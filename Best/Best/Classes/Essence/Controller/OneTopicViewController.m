//
//  OneTopicViewController.m
//  Best
//
//  Created by akkelyn on 16-4-24.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import "OneTopicViewController.h"
#import "NewViewController.h"
#import "HotCommentController.h"
#import "OneTopci.h"
#import "OnetopicCell.h"

#import <AFNetworking.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>

@interface OneTopicViewController ()

/* *保存OneTopic数据的数组*/
@property(nonatomic,strong)NSMutableArray *topicsArray;
/* *加载下一页需要的参数 */
@property(nonatomic,assign)NSUInteger page;
/* *加载下一页需要的参数*/
@property(nonatomic,copy)NSString *maxtime;
/* *保存上次请求参数的字典，用于判断返回数据是否是最新的请求*/
@property(nonatomic,strong)NSDictionary *params;
@property (nonatomic, assign) NSInteger lastSelectedIndex;
@end

@implementation OneTopicViewController

-(NSDictionary *)params
{
    if (_params == nil) {
        _params = [NSDictionary dictionary];
    }
    
    return _params;
}
-(NSMutableArray *)topicsArray
{
    if (_topicsArray == nil) {
        _topicsArray = [NSMutableArray array];
    }
    
    return _topicsArray;
}
- (NSString *)a
{
    return [self.parentViewController isKindOfClass:[NewViewController class]] ? @"newlist" : @"list";
}
static NSString *topicId = @"topicCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置tableview
    self.tableView.contentInset = UIEdgeInsetsMake(99, 0, 44, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OnetopicCell class]) bundle:nil] forCellReuseIdentifier:topicId];
    //刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNew)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    //tabbar按钮点击的通知
    [OneNoteCenter addObserver:self selector:@selector(tabbarDidSelected) name:OneTabBarDidSelectNotification object:nil];
}
#pragma mark - tabbar被点击两次
-(void)tabbarDidSelected
{
    if (self.lastSelectedIndex == self.tabBarController.selectedIndex && self.view.isShowingOnKeyWindow) {
        [self.tableView.mj_header beginRefreshing];
    }
    self.lastSelectedIndex = self.tabBarController.selectedIndex;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}
#pragma  mark - 下拉加载新的数据
-(void)loadNew
{
    [self.tableView.mj_footer endRefreshing];
    NSMutableDictionary  *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.OneType);
    self.params = params;
    
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
         if (self.params != params) return ;
        self.maxtime = responseObject[@"info"][@"maxtime"];
//        LynLog(@"%@",self.maxtime);
        self.topicsArray = [OneTopci mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        self.page = 0;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
          if (self.params != params) return ;
        [self.tableView.mj_header endRefreshing];
    }];
}
#pragma  mark - 上来加载更多数据
-(void)loadMore
{
    [self.tableView.mj_header endRefreshing];
    NSUInteger page = self.page + 1;
    NSMutableDictionary  *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.OneType);
    params[@"page"] = @(page);
    params[@"maxtime"] = self.maxtime;
//    LynLog(@"%d--%@",1,self.maxtime);
    self.params = params;
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if (self.params != params) return ;
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        NSArray *array = [OneTopci mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topicsArray addObjectsFromArray:array];
        
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        self.page = page;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
         [self.tableView.mj_footer endRefreshing];
    }];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topicsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OnetopicCell *cell = [tableView dequeueReusableCellWithIdentifier:topicId];
    cell.topci = self.topicsArray[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OneTopci *topic = self.topicsArray[indexPath.row];

    return topic.cellHeight;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotCommentController *commentVc  = [[HotCommentController alloc]init];
    commentVc.topci = self.topicsArray[indexPath.row];
    [self.navigationController pushViewController:commentVc animated:YES];
    
}
@end

//
//  OneRecommendViewController.m
//  One
//
//  Created by akkelyn on 16-4-22.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import "OneRecommendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>

#import "OneRecommendCategoryCell.h"
#import "OneRecommendTag.h"
#import <MJExtension.h>

#import "OneRecommendUserCell.h"
#import "OneRecommendUser.h"
#import <MJRefresh.h>

#define NowSelectCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]
@interface OneRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>

/**左边类别*/
@property(nonatomic,strong)NSArray *categories;
/**左边tableView*/
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/**右边tableView*/
@property (weak, nonatomic) IBOutlet UITableView *UserTableView;
/**请求参数*/
@property(nonatomic,strong)NSMutableDictionary *params;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation OneRecommendViewController

static NSString *const OneCategoryId = @"category";
static NSString *const OneUseryId = @"user";

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"推荐关注";
    self.view.backgroundColor = OneGlobalBg;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.UserTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.UserTableView.rowHeight = 70;
    self.categoryTableView.rowHeight = 44;

    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([OneRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:OneCategoryId];
    [self.UserTableView registerNib:[UINib nibWithNibName:NSStringFromClass([OneRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:OneUseryId];

    [self setUpRefresh];
    
    /**左侧标签请求*/
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
       
       [SVProgressHUD dismiss];
       self.categories = [OneRecommendTag mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
       
       [self.categoryTableView reloadData];
       
       [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
       
       [self.UserTableView.mj_header beginRefreshing];
       //LynLog(@"%@",self.categories);
   } failure:^(NSURLSessionDataTask *task, NSError *error) {
       [SVProgressHUD showErrorWithStatus:@"请求失败"];
       
   }];
}
#pragma  mark - t头部和尾部控件
-(void)setUpRefresh
{
    self.UserTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNew)];
    self.UserTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
}

#pragma  mark - 下拉加载新的数据
-(void)loadNew

{
    OneRecommendTag *RTag = NowSelectCategory;
    RTag.currentPage = 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] =  @(RTag.ID);
    params[@"page"] = @(RTag.currentPage);
    self.params = params;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
       
        [RTag.usersArray removeAllObjects];
        NSArray *users = [OneRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [RTag.usersArray addObjectsFromArray:users];
        RTag.total = [responseObject[@"total"] integerValue ];
        
        if (self.params != params) return;
        [self.UserTableView reloadData];
        [self.UserTableView.mj_header endRefreshing];
        
        self.UserTableView.mj_footer.hidden = (RTag .usersArray.count == 0);
        if (RTag.usersArray.count == RTag.total ) {
            [self.UserTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.UserTableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.params != params) return ;
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败，轻稍后再试"];
        [self.UserTableView.mj_header endRefreshing];
    }];

}

#pragma  mark - 上来加载更多的数据
-(void)loadMore
{
    OneRecommendTag *RTag  = NowSelectCategory;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] =  @(RTag.ID);
    params[@"page"] = @(++RTag.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
          LynLog(@"%@",responseObject[@"list"]);
        NSArray *users = [OneRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [RTag.usersArray addObjectsFromArray:users];
       
         if (self.params != params) return ;
        
        [self.UserTableView reloadData];
       
        self.UserTableView.mj_footer.hidden = (RTag .usersArray.count == 0);
        //底部刷新控件
        if (RTag.usersArray.count == RTag.total ) {
            [self.UserTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.UserTableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.params != params) return ;

    }];
     
}
#pragma  mark - tableview代理方法
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) {
        return self.categories.count;
    }else{
        OneRecommendTag *RTag= self.categories[self.categoryTableView.indexPathForSelectedRow.row];

        self.UserTableView.mj_footer.hidden = (RTag.usersArray.count == 0);
        //让底部控件结束
        if (RTag.usersArray.count == RTag.total) {
            [self.UserTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.UserTableView.mj_footer endRefreshing];
        }
        
        return RTag.usersArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {
        
        OneRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:OneCategoryId];
        cell.category = self.categories[indexPath.row];
        
        return  cell;
    }else{
        OneRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:OneUseryId];
    
        cell.user = [NowSelectCategory usersArray][indexPath.row];
        
        return  cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.UserTableView.mj_footer endRefreshing];
    [self.UserTableView.mj_header endRefreshing];
    
    OneRecommendTag *RTag = self.categories[indexPath.row];
    
    self.UserTableView.mj_footer.hidden = (RTag .usersArray.count == 0);
    if (RTag.usersArray.count) {
        [self.UserTableView reloadData];
    }else{
        [self.UserTableView reloadData];
        [self.UserTableView.mj_header beginRefreshing];
    }
}

- (void)dealloc
{
    [self.manager.operationQueue cancelAllOperations];
}

@end

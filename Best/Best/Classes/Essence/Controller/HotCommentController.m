//
//  HotCommentController.m
//  Best
//
//  Created by akkelyn on 16-4-26.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import "HotCommentController.h"
#import "OneCommentCell.h"
#import "OnetopicCell.h"
#import "OneTopci.h"
#import "OneComment.h"
#import "OneCommentHeaderView.h"

#import <MJExtension.h>
#import <MJRefresh.h>
#import <AFNetworking.h>

@interface HotCommentController ()<UITableViewDataSource,UITabBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *commentTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSapce;
/** 最热评论数组 */
@property (nonatomic, strong) NSArray *hotComments;
/** 最新评论的数组 */
@property (nonatomic, strong) NSMutableArray *latestComments;
/** 记住的top_cmt得到cellheiht */
@property (nonatomic, strong) OneComment *saved_top_cmt;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation HotCommentController
static NSString *const OneCommentId = @"comment";

-(AFHTTPSessionManager *)manager{

    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置tabbleview
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    self.commentTableView.estimatedRowHeight = 44;
    self.commentTableView.rowHeight = UITableViewAutomaticDimension;
    self.commentTableView.backgroundColor = OneGlobalBg;
    [self.commentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([OneCommentCell class]) bundle:nil] forCellReuseIdentifier:OneCommentId];
    self.commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.commentTableView.contentInset = UIEdgeInsetsMake(0, 0, OneTopicCellMargin, 0);
    //监听键盘的通知
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
   //header的设置
    UIView *header = [[UIView alloc] init];
    if (self.topci.top_cmt) {
        self.saved_top_cmt = self.topci.top_cmt;
        self.topci.top_cmt = nil;
        [self.topci setValue:@0 forKeyPath:@"cellHeight"];
    }
    OnetopicCell *cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([OnetopicCell class]) owner:nil options:nil] lastObject];
    cell.topci = self.topci;
    cell.size = CGSizeMake(OneScreenW, self.topci.cellHeight);
    [header addSubview:cell];
    header.height = self.topci.cellHeight + OneTopicCellMargin;
    self.commentTableView.tableHeaderView = header;
   //刷新控件
    self.commentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNew) ];
    self.commentTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.commentTableView.mj_footer.hidden = YES;
    [self.commentTableView.mj_header beginRefreshing];
}
-(void)loadNew{
   [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topci.ID;
    params[@"hot"] = @"1";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        LynLog(@"%@",responseObject);
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            [self.commentTableView.mj_header endRefreshing];
            return;
        }
        self.hotComments = [OneComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        self.latestComments = [OneComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.page = 1;
        [self.commentTableView reloadData];
        [self.commentTableView.mj_header endRefreshing];
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) {
            self.commentTableView.mj_footer.hidden = YES;
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.commentTableView.mj_header endRefreshing];
    }];

}
-(void)loadMore{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
  
    NSInteger page = self.page + 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topci.ID;
    params[@"page"] = @(page);
    OneComment *cmt = [self.latestComments lastObject];
    params[@"lastcid"] = cmt.ID;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            self.commentTableView.mj_footer.hidden = YES;
            return;
        }
       
        NSArray *newComments = [OneComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latestComments addObjectsFromArray:newComments];
        self.page = page;
  
        [self.commentTableView reloadData];
    
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) {
            self.commentTableView.mj_footer.hidden = YES;
        } else {
            [self.commentTableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.commentTableView.mj_footer endRefreshing];
    }];

}
#pragma  mark - 键盘弹出
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.bottomSapce.constant = OneScreenH - frame.origin.y;

    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
   
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}
#pragma mark - datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    
    if (hotCount) return 2;
    if (latestCount) return 1;
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    tableView.mj_footer.hidden = (latestCount == 0);
    
    if (section == 0) {
        return hotCount ? hotCount : latestCount;
    }
    return latestCount;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    OneCommentHeaderView *header = [OneCommentHeaderView headerViewWithTableView:tableView];
    
    NSInteger hotCount = self.hotComments.count;
    if (section == 0) {
        header.title = hotCount ? @"最热评论" : @"最新评论";
    } else {
        header.title = @"最新评论";
    }
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OneCommentCell*cell = [tableView dequeueReusableCellWithIdentifier:OneCommentId];
    
    cell.comment = [self commentInIndexPath:indexPath];
    
    return cell;
}
- (OneComment *)commentInIndexPath:(NSIndexPath *)indexPath
{
    return [self commentsInSection:indexPath.section][indexPath.row];
}
- (NSArray *)commentsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.latestComments;
    }
    return self.latestComments;
}
#pragma mark - tabledelelgate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIMenuController *menu = [UIMenuController sharedMenuController];
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
    } else {
        OneCommentCell *cell = (OneCommentCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        [cell becomeFirstResponder];
    
        UIMenuItem *ding = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)];
        UIMenuItem *replay = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(replay:)];
        UIMenuItem *report = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(report:)];
        menu.menuItems = @[ding, replay, report];
        CGRect rect = CGRectMake(0, cell.height * 0.5, cell.width, cell.height * 0.5);
        [menu setTargetRect:rect inView:cell];
        [menu setMenuVisible:YES animated:YES];
    }
}
#pragma markk -顶
- (void)ding:(UIMenuController *)menu
{
    NSIndexPath *indexPath = [self.commentTableView indexPathForSelectedRow];
    LynLog(@"%s %@", __func__, [self commentInIndexPath:indexPath].content);
}

- (void)replay:(UIMenuController *)menu
{
    NSIndexPath *indexPath = [self.commentTableView indexPathForSelectedRow];
    LynLog(@"%s %@", __func__, [self commentInIndexPath:indexPath].content);
}

- (void)report:(UIMenuController *)menu
{
    NSIndexPath *indexPath = [self.commentTableView indexPathForSelectedRow];
    LynLog(@"%s %@", __func__, [self commentInIndexPath:indexPath].content);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (self.saved_top_cmt) {
        self.topci.top_cmt = self.saved_top_cmt;
        [self.topci setValue:@0 forKeyPath:@"cellHeight"];
    }
    [self.manager invalidateSessionCancelingTasks:YES];
}

@end

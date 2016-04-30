//
//  OneTagViewController.m
//  Best
//
//  Created by akkelyn on 16-4-22.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import "OneTagViewController.h"
#import <SVProgressHUD.h>
#import <AFNetworking.h>
#import "HotCommentController.h"

#import <MJExtension.h>
#import "OneCommend.h"
#import "OneCommendCell.h"



@interface OneTagViewController ()

/**<#注释#>*/
@property(nonatomic,strong)NSArray *commendTag;
@end

@implementation OneTagViewController

static NSString *const comendId = @"tag";

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置tableview
    self.title = @"推荐标签";
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
    self.tableView.backgroundColor = OneGlobalBg;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OneCommendCell class]) bundle:nil] forCellReuseIdentifier:comendId];
    
   [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"c"] = @"topic";
    params[@"action"] = @"sub";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        self.commendTag = [OneCommend mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
    
}
#pragma mark - Tableviewdatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.commendTag.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OneCommendCell *cell = [tableView dequeueReusableCellWithIdentifier:comendId forIndexPath:indexPath];
    
    cell.commend = self.commendTag[indexPath.row];
    
    return cell;
}

@end

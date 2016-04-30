//
//  MeViewController.m
//  One
//
//  Created by akkelyn on 16-4-21.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import "MeViewController.h"
#import "OneMeCell.h"
#import "OneMeFooterView.h"
#import "SettingViewController.h"
@interface MeViewController ()

@end

@implementation MeViewController
static NSString *OneMeId = @"me";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationbar];
    // tableView
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 44, 0);
    self.tableView.backgroundColor = OneGlobalBg;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[OneMeCell class] forCellReuseIdentifier:OneMeId];
    self.tableView.tableFooterView = [[OneMeFooterView alloc] init];
    
    
}

- (void)setNavigationbar
{
    self.view.backgroundColor = OneGlobalBg;
    self.navigationItem.title = @"我的";
    
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
}

-(void)settingClick
{
    [self.navigationController pushViewController:[[SettingViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
}
-(void)moonClick
{

}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OneMeCell *cell = [tableView dequeueReusableCellWithIdentifier:OneMeId];
    
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"mine_icon_nearby"];
        cell.textLabel.text = @"登录/注册";
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"我的身份";
    }
    
    return cell;
}

@end

//
//  FriendTrendViewController.m
//  One
//
//  Created by akkelyn on 16-4-21.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import "FriendTrendViewController.h"
#import "OneRecommendViewController.h"
#import "OneLoginViewController.h"


@interface FriendTrendViewController ()

@end

@implementation FriendTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTableView
{
    self.navigationItem.title = @"我的关注";
   
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
   
    self.view.backgroundColor = OneGlobalBg;
}
-(void)friendsClick
{
    OneRecommendViewController *vc = [[OneRecommendViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)loginButtonClick:(id)sender {
    OneLoginViewController *loginVc=  [[OneLoginViewController alloc]init];
    [self presentViewController:loginVc animated:YES completion:^{
        
    }];
}

@end

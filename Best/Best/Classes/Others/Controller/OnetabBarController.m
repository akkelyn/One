//
//  OnetabBarController.m
//  One
//
//  Created by akkelyn on 16-4-21.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import "OnetabBarController.h"
#import "EssenceViewController.h"
#import "NewViewController.h"

#import "FriendTrendViewController.h"
#import "MeViewController.h"
#import "OneNavigationController.h"

#import "OneTabbar.h"


@interface OnetabBarController ()

@end

@implementation OnetabBarController

+(void)initialize
{
   UITabBarItem *item = [UITabBarItem appearance];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
   [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpChildViewController];
    
    [self setUpTabBar];
}

-(void)setUpChildViewController
{
    EssenceViewController *essnce = [[EssenceViewController alloc]init];
    [self setUpOneViewController:essnce image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon" title:@"精华"];
    
    NewViewController *new = [[NewViewController alloc]init];
    [self setUpOneViewController:new image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon" title:@"新帖"];

    FriendTrendViewController *frendTrend = [[FriendTrendViewController alloc]init];
    [self setUpOneViewController:frendTrend image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon" title:@"关注"];
    
     MeViewController *me = [[MeViewController alloc]init];
    [self setUpOneViewController:me image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon" title:@"我的"];

}

-(void)setUpOneViewController:(UIViewController *)vc image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    OneNavigationController *navc = [[OneNavigationController alloc]initWithRootViewController:vc];
    
    [self addChildViewController:navc];
}


-(void)setUpTabBar
{

    [self setValue:[[OneTabbar alloc]init] forKey:@"tabBar"];

}

@end
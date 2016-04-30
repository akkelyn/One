//
//  NewViewController.m
//  One
//
//  Created by akkelyn on 16-4-21.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import "NewViewController.h"

@interface NewViewController ()

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
}

-(void)setNavigationBar
{
    self.view.backgroundColor = OneGlobalBg;
    self.view.backgroundColor = [UIColor colorWithRed:(233)/255.0 green:(233)/255.0 blue:(233)/255.0 alpha:1.0];    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
}

- (void)tagClick
{
    
}

@end

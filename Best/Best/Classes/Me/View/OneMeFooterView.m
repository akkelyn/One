//
//  OneMeFooterView.m
//  Best
//
//  Created by akkelyn on 16-4-26.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import "OneMeFooterView.h"
#import "OneSquareBtn.h"
#import "OneWebViewController.h"
#import "OneSquare.h"

#import <AFNetworking.h>
#import <MJExtension.h>
#import <UIButton+WebCache.h>

@implementation OneMeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
      
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
    
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            NSArray *sqaures = [OneSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            LynLog(@"%lu",(unsigned long)sqaures.count);
        //添加按钮
            int maxCols = 4;
            CGFloat buttonW = OneScreenW / maxCols;
            CGFloat buttonH = buttonW;
            for (int i = 0; i<sqaures.count; i++) {
                OneSquareBtn *button = [OneSquareBtn buttonWithType:UIButtonTypeCustom];
                [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                button.square = sqaures[i];
                [self addSubview:button];
                
                int col = i % maxCols;
                int row = i / maxCols;
                button.x = col * buttonW;
                button.y = row * buttonH;
                button.width = buttonW;
                button.height = buttonH;
            }
            NSUInteger rows = (sqaures.count + maxCols - 1) / maxCols;
            self.height = rows * buttonH;
            
            [self setNeedsDisplay];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }
    return self;
}


- (void)buttonClick:(OneSquareBtn *)button
{
    LynLog(@"%@",button.square.url);
    if (![button.square.url hasPrefix:@"http"]) return;
    
    OneWebViewController *web = [[OneWebViewController alloc] init];
    web.url = button.square.url;
    web.title = button.square.name;
    UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)tabBarVc.selectedViewController;
    [nav pushViewController:web animated:YES];
}

@end

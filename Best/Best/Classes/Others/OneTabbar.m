//
//  OneTabbar.m
//  One
//
//  Created by akkelyn on 16-4-21.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import "OneTabbar.h"
#import "PublishViewController.h"

@interface OneTabbar()
@property (nonatomic,weak)UIButton *publishButton;
@end

@implementation OneTabbar


-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        
        [button addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        button.size = button.currentBackgroundImage.size;
        
        [self addSubview:button];
        self.publishButton = button;
    }
       return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 标记按钮是否已经添加过监听器
    static BOOL added = NO;
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;
    NSInteger index = 0;
    for (UIControl *button in self.subviews) {
        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton) continue;
        
        CGFloat buttonX = buttonW * ((index > 1)?(index + 1):index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        index++;
        if (added == NO) {
            
            [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    added = YES;
}
-(void)publishClick
{
    PublishViewController *publishVc = [[PublishViewController alloc]init];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publishVc animated:NO completion:^{
        
    }];

}
- (void)buttonClick
{
    [OneNoteCenter postNotificationName:OneTabBarDidSelectNotification object:nil userInfo:nil];

}

@end

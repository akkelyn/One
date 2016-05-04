//
//  PublishViewController.m
//  Best
//
//  Created by akkelyn on 16-4-26.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import "PublishViewController.h"
#import "VerticalLayoutButton.h"
#import "OneNavigationController.h"
#import "PostWordViewController.h"

#import <POP.h>

@interface PublishViewController ()

@end

@implementation PublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.userInteractionEnabled = NO;
    
    UIImageView *sloganView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    CGFloat sloaganCenterX = OneScreenW * 0.5;
    CGFloat sloganCenterEndY = OneScreenH * 0.2;
    [self.view addSubview:sloganView];
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.beginTime = CACurrentMediaTime() ;
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(sloaganCenterX, 0)];
    anim.springBounciness = 10;
    anim.springSpeed = 15;
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(sloaganCenterX, sloganCenterEndY)];
    [sloganView pop_addAnimation:anim forKey:nil];
    
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"视频", @"图片", @"段子", @"声音", @"审帖", @"离线下载"];
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = 100;
    CGFloat startX = 15;
    CGFloat startY = (OneScreenH - 2*buttonH)*0.5;
    CGFloat btnMargin = (OneScreenW - maxCols * buttonW -2 *startX) /(maxCols - 1);
    for (int i = 0 ; i < 6; i++) {
        VerticalLayoutButton *btn = [[VerticalLayoutButton alloc]init];
        btn.tag = i;
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        int row = i / maxCols;
        int cols = i %maxCols;
        btn.width = buttonW;
        btn.height = buttonH;
        CGFloat buttonX = startX + cols * (btnMargin + buttonW);
        CGFloat buttonEndY = startY + row *(buttonH + btnMargin);
        CGFloat buttonBeginY = buttonEndY - OneScreenH;
       
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame ];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY,buttonW , buttonH)];
        anim.beginTime = CACurrentMediaTime() + 0.05 * i;
        anim.springBounciness = 10;
        anim.springSpeed = 15;
        [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
            self.view.userInteractionEnabled = YES;
        }];
        
        [btn pop_addAnimation:anim forKey:nil];
        
        [self.view addSubview:btn];
        
        
    }
    
}
#pragma mark - 按钮点击
- (void)buttonClick:(UIButton *)button
{
   
    [self cancelWithCompletionBlock:^{
        if (button.tag == 2) {
            PostWordViewController *postWord = [[PostWordViewController alloc] init];
            OneNavigationController *nav = [[OneNavigationController alloc] initWithRootViewController:postWord];
            UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
            [root presentViewController:nav animated:YES completion:nil];
        }
    }];
}

- (IBAction)cancelBtn {
  [self cancelWithCompletionBlock:nil];
    
}
- (void)cancelWithCompletionBlock:(void (^)())completionBlock
{
    self.view.userInteractionEnabled = NO;
    
    for (int i = 2; i<self.view.subviews.count; i++) {
        UIView *subview = self.view.subviews[i];
        
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subview.centerY + OneScreenH;
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subview.centerX, centerY)];
        anim.beginTime = CACurrentMediaTime() + (i - 2 ) * 0.05;
        [subview pop_addAnimation:anim forKey:nil];
        
        if (i == self.view.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                [self dismissViewControllerAnimated:NO completion:nil];
                if (completionBlock)
                 completionBlock();
            }];
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self cancelWithCompletionBlock:nil];
}

@end

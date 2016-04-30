//
//  OneLoginViewController.m
//  Best
//
//  Created by akkelyn on 16-4-23.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import "OneLoginViewController.h"

@interface OneLoginViewController ()
/**登录总界面距离view左边的距离约束*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;


@end

@implementation OneLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
/***********设置placeholder***********/
    
////    self.phoneNumber.placeholder =  @"账号";
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[NSForegroundColorAttributeName] = [UIColor yellowColor];
//    NSAttributedString *placeholderStr = [[NSAttributedString alloc]initWithString:@"账号" attributes:dict];
//    self.phoneNumber.attributedPlaceholder = placeholderStr;
    
///*   *富文本设置占位文字（但是得通过代理或者通知来监听文本的改变从而再重新设置占位文字的属性）*   */
//    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
//    attrDict[NSForegroundColorAttributeName] = [UIColor yellowColor];
//    
//    NSMutableAttributedString *placeholderStr = [[NSMutableAttributedString alloc]initWithString:@"您的手机号" attributes:attrDict];
//    [placeholderStr setAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor],
//                                    NSFontAttributeName : [UIFont systemFontOfSize:20]
//                                   } range:NSMakeRange(0, 1)];
//    
//    self.phoneNumber.attributedPlaceholder = placeholderStr
    
}
- (IBAction)showRegister:(UIButton *)button {
    
   [self.view endEditing:YES];
    
    if (self.loginViewLeftMargin.constant == 0) {
        self.loginViewLeftMargin.constant = -self.view.width;
        [button setTitle:@"已有账号" forState:UIControlStateNormal];
    }else{
     self.loginViewLeftMargin.constant = 0;
        [button setTitle:@"注册账号" forState:UIControlStateNormal];
    }
    [UIView animateWithDuration:0.5 delay:0  usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];

    
}

- (IBAction)baclBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end

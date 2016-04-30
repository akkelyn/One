//
//  OneGuideView.m
//  Best
//
//  Created by akkelyn on 16-4-24.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import "OneGuideView.h"

@implementation OneGuideView
- (IBAction)KnowButton:(id)sender {
    
    [self removeFromSuperview];
}

+(instancetype)guideView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];

}
+(void)showGuideView
{
    NSString *keyStr= @"CFBundleShortVersionString";
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[keyStr];
    NSString *sandboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:keyStr];
    if (![currentVersion isEqualToString:sandboxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        OneGuideView *guideView = [OneGuideView guideView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        
        [[NSUserDefaults standardUserDefaults]setObject:currentVersion forKey:@"keyStr"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }

}

@end

//
//  UIBarButtonItem+item.h
//  One
//
//  Created by akkelyn on 16-4-22.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (item)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end

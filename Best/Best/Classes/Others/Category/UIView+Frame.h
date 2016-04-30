//
//  UIView+Frame.h
//  One
//
//  Created by akkelyn on 16-4-22.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)


@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

/* *判断view是否在主窗口上 */
- (BOOL)isShowingOnKeyWindow;
@end

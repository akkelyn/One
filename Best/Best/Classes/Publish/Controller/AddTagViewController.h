//
//  AddTagViewController.h
//  Best
//
//  Created by akkelyn on 16-4-26.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTagViewController : UIViewController
@property (nonatomic, copy) void (^tagsBlock)(NSArray *tags);

@property (nonatomic, strong) NSArray *tags;
@end

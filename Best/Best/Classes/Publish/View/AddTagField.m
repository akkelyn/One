//
//  AddTagField.m
//  Best
//
//  Created by akkelyn on 16-4-26.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import "AddTagField.h"

@implementation AddTagField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.placeholder = @"多个标签用逗号或者换行隔开";
        
        [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        self.height = OneTagH;
    }
    return self;
}


- (void)deleteBackward
{
    !self.deleteBlock ? : self.deleteBlock();
    
    [super deleteBackward];
}


@end

//
//  OneTextField.m
//  Best
//
//  Created by akkelyn on 16-4-23.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import "OneTextField.h"
#import <objc/runtime.h>

static NSString * const OnePlacerholderColorKeyPath = @"_placeholderLabel.textColor";
@implementation OneTextField

////重写drawplacedolder实现占位文字的颜色改变就
//-(void)drawPlaceholderInRect:(CGRect)rect
//{
//    [super drawPlaceholderInRect:rect];//默认的为占位文字会灰色的
////    [self.placeholder drawInRect:CGRectMake(0, 15, 100, 100) withAttributes:@{NSForegroundColorAttributeName :                      [UIColor grayColor],
////                                                      NSFontAttributeName : self.font
////                                                       }];
//}

//+(void)initialize
//{
//    unsigned int count = 0;
//    
//    Ivar *ivars = class_copyIvarList([UITextField class], &count);
//    
//    for (int  i  = 0; i < count; i++) {
//        Ivar  ivar = *(ivars +  i);
//        LynLog(@"%s",ivar_getName(ivar));
//    }
//    free(ivars);
//}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tintColor  =  self.textColor;//光标颜色
        [self resignFirstResponder];
    }
    return self;
}
- (void)awakeFromNib
{
    self.tintColor = self.textColor;
    [self resignFirstResponder];
}

- (BOOL)becomeFirstResponder
{
    
    [self setValue:self.textColor forKeyPath:OnePlacerholderColorKeyPath];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    [self setValue:[UIColor grayColor] forKeyPath:OnePlacerholderColorKeyPath];
    return [super resignFirstResponder];
}
@end

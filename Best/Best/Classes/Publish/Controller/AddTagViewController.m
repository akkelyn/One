//
//  AddTagViewController.m
//  Best
//
//  Created by akkelyn on 16-4-26.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import "AddTagViewController.h"
#import "AddTagField.h"
#import "TagButton.h"
#import <SVProgressHUD.h>

@interface AddTagViewController ()<UITextFieldDelegate>
@property (nonatomic, weak) UIView *contentView;
/** 文本输入框 */
@property (nonatomic, weak) AddTagField *textField;
/** 添加按钮 */
@property (nonatomic, weak) UIButton *addButton;
/** 所有的标签按钮 */
@property (nonatomic, strong) NSMutableArray *tagButtons;
@end

@implementation AddTagViewController

- (NSMutableArray *)tagButtons
{
    if (!_tagButtons) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}

- (UIButton *)addButton
{
    if (!_addButton) {
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.height = 35;
        [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        addButton.titleLabel.font = OneTagFont;
        addButton.contentEdgeInsets = UIEdgeInsetsMake(0, OneTagMargin, 0, OneTagMargin);
        // 让按钮内部的文字和图片都左对齐
        addButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        addButton.backgroundColor = OneTagBg;
        [self.contentView addSubview:addButton];
        _addButton = addButton;
    }
    return _addButton;
}

- (UIView *)contentView
{
    if (!_contentView) {
        UIView *contentView = [[UIView alloc] init];
        [self.view addSubview:contentView];
        self.contentView = contentView;
    }
    return _contentView;
}

- (AddTagField *)textField
{
    if (!_textField) {
        __weak typeof(self) weakSelf = self;
        AddTagField *textField = [[AddTagField alloc] init];
        textField.deleteBlock = ^{
            if (weakSelf.textField.hasText) return;
            
            [weakSelf tagButtonClick:[weakSelf.tagButtons lastObject]];
        };
        textField.delegate = self;
        [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
        [textField becomeFirstResponder];
        [self.contentView addSubview:textField];
        self.textField = textField;
    }
    return _textField;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
}

- (void)setupTags
{
    if (self.tags.count) {
        for (NSString *tag in self.tags) {
            self.textField.text = tag;
            [self addButtonClick];
        }
        
        self.tags = nil;
    }
}

- (void)setupNav
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加标签";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
}

- (void)done
{
    NSArray *tags = [self.tagButtons valueForKeyPath:@"currentTitle"];
    !self.tagsBlock ? : self.tagsBlock(tags);
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.contentView.x = OneTagMargin;
    self.contentView.width = self.view.width - 2 * self.contentView.x;
    self.contentView.y = 64 + OneTagMargin;
    self.contentView.height = OneScreenH;
    
    self.textField.width = self.contentView.width;
    
    self.addButton.width = self.contentView.width;
    
    [self setupTags];
}

#pragma mark - 监听文字改变

- (void)textDidChange
{
    [self updateTextFieldFrame];
    
    if (self.textField.hasText) {
        self.addButton.hidden = NO;
        self.addButton.y = CGRectGetMaxY(self.textField.frame) + OneTagMargin;
        [self.addButton setTitle:[NSString stringWithFormat:@"添加标签: %@", self.textField.text] forState:UIControlStateNormal];
        
        NSString *text = self.textField.text;
        NSUInteger len = text.length;
        NSString *lastLetter = [text substringFromIndex:len - 1];
        if ([lastLetter isEqualToString:@","]
            || [lastLetter isEqualToString:@"，"]) {
           
            self.textField.text = [text substringToIndex:len - 1];
            
            [self addButtonClick];
        }
    } else {
        self.addButton.hidden = YES;
    }
}

#pragma mark - 监听按钮点击

- (void)addButtonClick
{
    if (self.tagButtons.count == 5) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        return;
    }
    
    // 添加一个"标签按钮"
    TagButton *tagButton = [TagButton buttonWithType:UIButtonTypeCustom];
    [tagButton addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    [self.contentView addSubview:tagButton];
    [self.tagButtons addObject:tagButton];
    
    // 清空textField文字
    self.textField.text = nil;
    self.addButton.hidden = YES;
    
    // 更新标签按钮的frame
    [self updateTagButtonFrame];
    [self updateTextFieldFrame];
}

/**
 * 标签按钮的点击
 */
- (void)tagButtonClick:(TagButton *)tagButton
{
    [tagButton removeFromSuperview];
    [self.tagButtons removeObject:tagButton];
    
    // 重新更新所有标签按钮的frame
    [UIView animateWithDuration:0.25 animations:^{
        [self updateTagButtonFrame];
        [self updateTextFieldFrame];
    }];
}

#pragma mark - 子控件的frame处理
/**
 * 专门用来更新标签按钮的frame
 */
- (void)updateTagButtonFrame
{
    for (int i = 0; i<self.tagButtons.count; i++) {
        TagButton *tagButton = self.tagButtons[i];
        
        if (i == 0) {
            tagButton.x = 0;
            tagButton.y = 0;
        } else {
            TagButton *lastTagButton = self.tagButtons[i - 1];
           
            CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + OneTagMargin;
            
            CGFloat rightWidth = self.contentView.width - leftWidth;
            if (rightWidth >= tagButton.width) {
                tagButton.y = lastTagButton.y;
                tagButton.x = leftWidth;
            } else {                tagButton.x = 0;
                tagButton.y = CGRectGetMaxY(lastTagButton.frame) + OneTagMargin;
            }
        }
    }
}

- (void)updateTextFieldFrame
{
    TagButton *lastTagButton = [self.tagButtons lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + OneTagMargin;
    if (self.contentView.width - leftWidth >= [self textFieldTextWidth]) {
        self.textField.y = lastTagButton.y;
        self.textField.x = leftWidth;
    } else {
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY(lastTagButton.frame) + OneTagMargin;
    }
    self.addButton.y = CGRectGetMaxY(self.textField.frame) + OneTagMargin;
}
- (CGFloat)textFieldTextWidth
{
    CGFloat textW = [self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width;
    return MAX(100, textW);
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textFieldShouldReturn:(AddTagField *)textField
{
    if (textField.hasText) {
        [self addButtonClick];
    }
    return YES;
}

@end

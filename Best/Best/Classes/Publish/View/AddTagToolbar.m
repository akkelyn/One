//
//  AddTagToolbar.m
//  Best
//
//  Created by akkelyn on 16-4-26.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import "AddTagToolbar.h"
#import "AddTagViewController.h"

@interface AddTagToolbar ()

@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) UIButton *addButton;

@property (nonatomic, strong) NSMutableArray *tagLabels;
@end
@implementation AddTagToolbar

- (NSMutableArray *)tagLabels
{
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}

- (void)awakeFromNib
{
    UIButton *addButton = [[UIButton alloc] init];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    addButton.size = addButton.currentImage.size;
    addButton.x = OneTagMargin;
    [self.topView addSubview:addButton];
    self.addButton = addButton;
    [self createTagLabels:@[@"吐槽", @"糗事"]];
}

- (void)addButtonClick
{
    AddTagViewController *vc = [[AddTagViewController alloc] init];
    __weak typeof(self) weakSelf = self;
    [vc setTagsBlock:^(NSArray *tags) {
        [weakSelf createTagLabels:tags];
    }];
    vc.tags = [self.tagLabels valueForKeyPath:@"text"];
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)root.presentedViewController;
    [nav pushViewController:vc animated:YES];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (int i = 0; i<self.tagLabels.count; i++) {
        UILabel *tagLabel = self.tagLabels[i];
        if (i == 0) {
            tagLabel.x = 0;
            tagLabel.y = 0;
        } else {
            UILabel *lastTagLabel = self.tagLabels[i - 1];
            
            CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + OneTagMargin;
            
            CGFloat rightWidth = self.topView.width - leftWidth;
            if (rightWidth >= tagLabel.width) {
                tagLabel.y = lastTagLabel.y;
                tagLabel.x = leftWidth;
            } else {
                tagLabel.x = 0;
                tagLabel.y = CGRectGetMaxY(lastTagLabel.frame) + OneTagMargin;
            }
        }
    }
    UILabel *lastTagLabel = [self.tagLabels lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + OneTagMargin;
    
    if (self.topView.width - leftWidth >= self.addButton.width) {
        self.addButton.y = lastTagLabel.y;
        self.addButton.x = leftWidth;
    } else {
        self.addButton.x = 0;
        self.addButton.y = CGRectGetMaxY(lastTagLabel.frame) + OneTagMargin;
    }
    
    CGFloat oldH = self.height;
    self.height = CGRectGetMaxY(self.addButton.frame) + 45;
    self.y -= self.height - oldH;
}

- (void)createTagLabels:(NSArray *)tags
{
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    
    for (int i = 0; i<tags.count; i++) {
        UILabel *tagLabel = [[UILabel alloc] init];
        [self.tagLabels addObject:tagLabel];
        tagLabel.backgroundColor = OneTagBg;
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.text = tags[i];
        tagLabel.font = OneTagFont;

        [tagLabel sizeToFit];
        tagLabel.width += 2 * OneTagMargin;
        tagLabel.height = OneTagH;
        tagLabel.textColor = [UIColor whiteColor];
        [self.topView addSubview:tagLabel];
    }
    [self setNeedsLayout];
}

@end

//
//  OneRecommendCategoryCell.m
//  Best
//
//  Created by akkelyn on 16-4-22.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import "OneRecommendCategoryCell.h"
#import "OneRecommendTag.h"

@interface OneRecommendCategoryCell ()
@property (weak, nonatomic) IBOutlet UIView *leftIndicator;

@end

@implementation OneRecommendCategoryCell

- (void)awakeFromNib {
    self.backgroundColor = OneRGBColor(244, 244, 244);
    
 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.leftIndicator.hidden = !selected;
    self.textLabel.textColor = selected?OneRGBColor(219, 21 , 26):OneRGBColor(78, 78, 78);
}

-(void)setCategory:(OneRecommendTag *)category
{
    _category = category;
    
    self.textLabel.text = category.name;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 *self.textLabel.y;
}
@end

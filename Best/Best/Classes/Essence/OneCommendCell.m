//
//  OneCommendCell.m
//  Best
//
//  Created by akkelyn on 16-4-30.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import "OneCommendCell.h"
#import "OneCommend.h"
#import <UIImageView+WebCache.h>

@interface OneCommendCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;

@end
@implementation OneCommendCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCommend:(OneCommend *)commend
{
    _commend = commend;
    
    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:commend.image_list] placeholderImage:[[UIImage imageNamed:@"defaultUserIcon"] imageCircle] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    
    self.themeNameLabel.text = commend.theme_name;
    NSString *subNumber = nil;
    if (commend.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人订阅", commend.sub_number];
    } else {
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅", commend.sub_number / 10000.0];
    }
    self.subNumberLabel.text = subNumber;
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    
    [super setFrame:frame];
}
@end

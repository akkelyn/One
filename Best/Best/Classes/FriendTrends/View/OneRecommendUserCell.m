//
//  OneRecommendUserCell.m
//  Best
//
//  Created by akkelyn on 16-4-22.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import "OneRecommendUserCell.h"
#import "OneRecommendUser.h"
#import <UIImageView+WebCache.h>

@interface OneRecommendUserCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerView;

@property (weak, nonatomic) IBOutlet UILabel *nickname;

@property (weak, nonatomic) IBOutlet UILabel *fansCount;

@end
@implementation OneRecommendUserCell

- (void)awakeFromNib {
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setUser:(OneRecommendUser *)user
{
    self.nickname.text = user.screen_name;
    
    [self.headerView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[[UIImage imageNamed:@"setup-head-default"] imageCircle] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.headerView.image =  [image imageCircle];
    }
     ];
    
    NSString *fansCount = nil;
    if (user.fans_count < 10000) {
        fansCount = [NSString stringWithFormat:@"%zd人关注", user.fans_count];
    } else { 
        fansCount = [NSString stringWithFormat:@"%.1f万人关注", user.fans_count / 10000.0];
    }
    self.fansCount.text = fansCount;
}
@end

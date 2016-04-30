//
//  OneTopicVideoView.m
//  Best
//
//  Created by akkelyn on 16-4-25.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import "OneTopicVideoView.h"
#import "OneTopci.h"
#import <UIImageView+WebCache.h>
#import "ShowPictureViewController.h"

@interface OneTopicVideoView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;

@end

@implementation OneTopicVideoView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

- (void)showPicture
{
    ShowPictureViewController  *showPicture = [[ShowPictureViewController alloc] init];
    showPicture.topci = self.topci;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}

- (void)setTopci:(OneTopci *)topci
{
    _topci = topci;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topci.large_image]];
   
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放", topci.playcount];
    
    NSInteger minute = topci.videotime / 60;
    NSInteger second = topci.videotime % 60;
    self.videotimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
}

@end

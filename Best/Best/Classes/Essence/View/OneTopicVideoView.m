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
#import "OneVideoPlayView.h"

@interface OneTopicVideoView ()<OneVideoPlayViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;
@property (nonatomic, weak) OneVideoPlayView *playView;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;


///** 内存缓存 */
//@property (nonatomic, strong) NSMutableDictionary *items;
///** 所有的操作对象 */
//@property (nonatomic, strong) NSMutableDictionary *operations;
///** 队列对象 */
//@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation OneTopicVideoView

//-(OneVideoPlayView *)playView
//{
//    if (_playView == nil) {
//        _playView = [OneVideoPlayView videoPlayView];
//        _playView.frame = self.imageView.bounds;
//        [self.imageView addSubview:_playView];
//        _playView.delegate = self;
//        self.playView = _playView;
//    }
//    
//    return _playView;
//}
- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageView.userInteractionEnabled = YES;
//    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playVideo)]];
    
  
}

//- (void)playVideo
//{
//    LynLog(@"playvideo");
//}

- (void)setTopci:(OneTopci *)topci
{
    _topci = topci;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topci.large_image]];
   
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放", topci.playcount];
    
    NSInteger minute = topci.videotime / 60;
    NSInteger second = topci.videotime % 60;
    self.videotimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
    
    if (self.playView) {
        [self.playView removeFromSuperview];
        
    }else{
        self.playView = [OneVideoPlayView videoPlayView];
        self.playView.frame = self.imageView.bounds;
        [self.imageView addSubview:_playView];
        self.playView.hidden = YES;
    }
    
}
- (IBAction)buttonClick:(id)sender {
    LynLog(@"buttonclick");
    self.playBtn.hidden = YES;
    self.videotimeLabel.hidden = YES;
    self.playcountLabel.hidden = YES;
    self.playView.hidden = NO;
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.topci.videouri]];
    self.playView.playerItem = item;
}

@end

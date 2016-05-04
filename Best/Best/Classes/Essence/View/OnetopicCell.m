//
//  OnetopicCell.m
//  Best
//
//  Created by akkelyn on 16-4-24.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import "OnetopicCell.h"
#import "OneTopci.h"
#import "OnePictureView.h"
#import "OneTopicVideoView.h"
#import "OneTopicVoiceVIew.h"
#import "OneComment.h"
#import "OneUser.h"


#import <UIImageView+WebCache.h>

@interface OnetopicCell ()<UIActionSheetDelegate>
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UILabel *oneTextlabel;


/* *图片声音视频控件 */
@property(nonatomic,weak)OnePictureView *pictureView;
@property (nonatomic, weak)OneTopicVoiceVIew *voiceView;
/** 视频帖子中间的内容 */
@property (nonatomic, weak)OneTopicVideoView *videoView;
/** 最热评论的内容 */
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;
/** 最热评论的整体 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@end
@implementation OnetopicCell

-(OnePictureView *)pictureView
{
    if (!_pictureView ) {
        OnePictureView *pictureView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([OnePictureView class]) owner:nil options:nil] lastObject];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    
    return  _pictureView;
}

- (OneTopicVoiceVIew *)voiceView
{
    if (!_voiceView) {
        OneTopicVoiceVIew *voiceView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([OneTopicVoiceVIew class]) owner:nil options:nil] lastObject];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (OneTopicVideoView *)videoView
{
    if (!_videoView) {
        OneTopicVideoView *videoView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([OneTopicVideoView class]) owner:nil options:nil] lastObject];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}
- (void)awakeFromNib {
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

-(void)setTopci:(OneTopci *)topci
{
    _topci = topci;

    self.textLabel.text = topci.name;
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topci.profile_image]  placeholderImage:[[UIImage imageNamed:@"defaultUserIcon"] imageCircle] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.profileImageView.image = [image imageCircle];
    } ];
    self.nameLabel.text = topci.name;
    self.createTimeLabel.text = topci.create_time;
    self.oneTextlabel.text = topci.text;
    
    [self setupButtonTitle:self.dingButton count:topci.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topci.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topci.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:topci.comment placeholder:@"评论"];
     self.oneTextlabel.text = topci.text;
    
    if (topci.type == OneTopicTypePicture) {
        self.pictureView.hidden = NO;
        self.pictureView.topci = topci;
        self.pictureView.frame = topci.pictureF;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
        
    } else if (topci.type == OneTopicTypeVoice) {
        self.voiceView.hidden = NO;
        self.voiceView.topci = topci;
        self.voiceView.frame = topci.voiceF;
        
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    } else if (topci.type == OneTopicTypeVideo) {
        self.videoView.hidden = NO;
        self.videoView.topci = topci;
        self.videoView.frame = topci.videoF;
        
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    } else {
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }
    if (topci.top_cmt) {
        self.topCmtView.hidden = NO;
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@", topci.top_cmt.user.username, topci.top_cmt.content];
    } else {
        self.topCmtView.hidden = YES;
    }
    
}
#pragma mark - 设置工具条按钮
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}
-(void)setFrame:(CGRect)frame
{
    frame.size.height = self.topci.cellHeight - OneTopicCellMargin;
    frame.origin.y += OneTopicCellMargin;

    [super setFrame:frame];
}
- (IBAction)choice:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏",@"举报",nil];
    [sheet showInView:self.window];
}
@end

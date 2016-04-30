//
//  OnePictureView.m
//  Best
//
//  Created by akkelyn on 16-4-25.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import "OnePictureView.h"
#import "OneTopci.h"
#import "OneProgressView.h"
#import "ShowPictureViewController.h"

#import <UIImageView+WebCache.h>
@interface OnePictureView ()
/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** gif标识 */
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
/** 查看大图按钮 */
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
///** 进度条控件 */
 @property (weak, nonatomic) IBOutlet OneProgressView *progressView;
@end


@implementation OnePictureView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    // 给图片添加监听器
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}
- (void)showPicture
{
    ShowPictureViewController *showPicture = [[ShowPictureViewController alloc] init];
    showPicture.topci = self.topci;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}

- (void)setTopci:(OneTopci *)topci
{
    _topci = topci;
 
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topci.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        topci.pictureProgress = 1.0 * receivedSize / expectedSize;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (topci.isBigPicture == NO) return;

        UIGraphicsBeginImageContextWithOptions(topci.pictureF.size, YES, 0.0);
        CGFloat width = topci.pictureF.size.width;
        CGFloat height = width * image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0, width , height)];
        
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }];
    NSString *extension = topci.large_image.pathExtension;
    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    if (topci.isBigPicture) {
        self.seeBigButton.hidden = NO;
    } else {
        self.seeBigButton.hidden = YES;
    }
}
-(void)setFrame:(CGRect)frame
{
    CGFloat margin =  10;
    frame.size.width -= margin;
    
    [super setFrame:frame];
}
@end

//
//  OneTopci.m
//  Best
//
//  Created by akkelyn on 16-4-24.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import "OneTopci.h"
#import "OneUser.h"
#import "OneComment.h"

#import <MJExtension.h>
@implementation OneTopci
{
    CGFloat _cellHeight;
    CGRect  _pictureF;
    CGRect  _voiceF;
    CGRect  _videoF;
}

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2",
             @"ID" : @"id",
             @"top_cmt" : @"top_cmt[0]"
             };

}
- (NSString *)create_time
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *create = [fmt dateFromString:_create_time];
    
    if (create.isThisYear) {
        if (create.isToday) {
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) {
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else {
                return @"刚刚";
            }
        } else if (create.isYesterday) { 
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else {
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    } else { 
        return _create_time;
    }
}
#pragma  mark - 计算cell的高度
-(CGFloat)cellHeight
{
    if (!_cellHeight ) {
        CGSize maxSize =  CGSizeMake([UIScreen mainScreen].bounds.size.width , MAXFLOAT);
        CGFloat textHeight = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        _cellHeight =OneTopicCellTextY + textHeight +  OneTopicCellMargin;
        
        if (self.type == OneTopicTypePicture) {
            if (self.width != 0 && self.height != 0) {
                CGFloat pictureW = maxSize.width - OneTopicCellMargin;
                CGFloat pictureH = pictureW * self.height / self.width;
                if (pictureH >= OneTopicCellPictureMaxH) {
                    pictureH = OneTopicCellPictureBreakH;
                    self.bigPicture = YES;
                }
                CGFloat pictureX = OneTopicCellMargin ;
                CGFloat pictureY = OneTopicCellTextY + textHeight + OneTopicCellMargin;
                _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
                _cellHeight += pictureH + OneTopicCellMargin;
            }
        } else if (self.type == OneTopicTypeVoice) {
            CGFloat voiceX = OneTopicCellMargin ;
            CGFloat voiceY = OneTopicCellTextY + textHeight + OneTopicCellMargin;
            CGFloat voiceW = maxSize.width - 2 * OneTopicCellMargin;
            CGFloat voiceH = voiceW * self.height / self.width;
            _voiceF = CGRectMake(voiceX, voiceY, voiceW , voiceH);
            
            _cellHeight += voiceH + OneTopicCellMargin;
        } else if (self.type == OneTopicTypeVideo) {
            CGFloat videoX = OneTopicCellMargin;
            CGFloat videoY = OneTopicCellTextY + textHeight + OneTopicCellMargin;
            CGFloat videoW = maxSize.width - 2 * OneTopicCellMargin;
            CGFloat videoH = videoW * self.height / self.width;
            _videoF = CGRectMake(videoX, videoY, videoW, videoH);
            
            _cellHeight += videoH + OneTopicCellMargin;
        }
        if (self.top_cmt) {
            NSString *content = [NSString stringWithFormat:@"%@ : %@", self.top_cmt.user.username, self.top_cmt.content];
            CGFloat contentH = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
            _cellHeight += OneTopicCellTopCmtTitleH + contentH + OneTopicCellMargin ;
        }
        _cellHeight += OneTopicCellBottomBarH + OneTopicCellMargin;
    }

    return _cellHeight;
}
@end

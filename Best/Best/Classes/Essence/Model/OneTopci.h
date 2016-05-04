//
//  OneTopci.h
//  Best
//
//  Created by akkelyn on 16-4-24.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OneComment;
@interface OneTopci : NSObject

/** id */
@property (nonatomic, copy) NSString *ID;
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 头像的URL */
@property (nonatomic, copy) NSString *profile_image;
/** 发帖时间 */
@property (nonatomic, copy) NSString *create_time;
/** 文字内容 */
@property (nonatomic, copy) NSString *text;
/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;
/** 最热评论 */
@property (nonatomic, strong) OneComment *top_cmt;
/** 小图片的URL */
@property (nonatomic, copy) NSString *small_image;
/** 中图片的URL */
@property (nonatomic, copy) NSString *middle_image;
/** 大图片的URL */
@property (nonatomic, copy) NSString *large_image;
/** 帖子的类型 */
@property (nonatomic, assign) OneTopicType type;
/** 图片的宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片的高度 */
@property (nonatomic, assign) CGFloat height;
/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 播放次数 */
@property (nonatomic, assign) NSInteger playcount;

/** 视频的url */
@property(nonatomic,strong)NSString *videouri;

/* *******************辅助 ************************ */

/**每个cell的高度*/
@property(nonatomic,assign,readonly)CGFloat cellHeight;
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;
@property (nonatomic, assign, readonly) CGRect pictureF;
/** 图片的下载进度 */
@property (nonatomic, assign) CGFloat pictureProgress;
/** 声音控件的frame */
@property (nonatomic, assign, readonly) CGRect voiceF;
/** 视频控件的frame */
@property (nonatomic, assign, readonly) CGRect videoF;
@end

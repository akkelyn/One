//
//  OneComment.h
//  Best
//
//  Created by akkelyn on 16-4-25.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OneUser;
@interface OneComment : NSObject

/** id */
@property (nonatomic, copy) NSString *ID;
/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;
/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;
/** 用户 */
@property (nonatomic, strong) OneUser *user;

@end

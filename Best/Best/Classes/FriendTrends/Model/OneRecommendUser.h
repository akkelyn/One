//
//  OneRecommendUser.h
//  Best
//
//  Created by akkelyn on 16-4-22.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OneRecommendUser : NSObject

/**头像*/
@property (nonatomic, copy) NSString *header;
/**粉丝数*/
@property (nonatomic, assign) NSInteger fans_count;
/**昵称*/
@property (nonatomic, copy) NSString *screen_name;
@end

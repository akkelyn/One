//
//  OneCommend.h
//  Best
//
//  Created by akkelyn on 16-4-22.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OneCommend;
@interface OneCommend : NSObject
/**主题id*/
@property (nonatomic,copy)NSString *theme_id;
/**昵称*/
@property(nonatomic,copy)NSString *theme_name;
/**订阅数*/
@property (nonatomic,assign)NSInteger sub_number;
/**图片*/
@property(nonatomic,copy)NSString *image_list;

@end

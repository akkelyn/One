//
//  NSDate+NSDateExtension.h
//  Best
//
//  Created by akkelyn on 16-4-25.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (NSDateExtension)

/* *比较两个时间的差值  */
-(NSDateComponents *)deltaFrom:(NSDate *)from;
/* *是否是今年 */
-(BOOL)isThisYear;
/* *是否是今天 */
- (BOOL)isToday;
/* *是否是昨天 */
- (BOOL)isYesterday;

@end

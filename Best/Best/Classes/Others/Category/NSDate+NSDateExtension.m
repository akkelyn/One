//
//  NSDate+NSDateExtension.m
//  Best
//
//  Created by akkelyn on 16-4-25.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import "NSDate+NSDateExtension.h"

@implementation NSDate (NSDateExtension)
-(NSDateComponents *)deltaFrom:(NSDate *)from
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitSecond | NSCalendarUnitMinute |NSCalendarUnitHour |NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear ;
    return [calendar components:unit fromDate:from toDate:self options:0];
}


- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    return nowYear == selfYear;
}

- (BOOL)isToday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSString *selfString = [fmt stringFromDate:self];
    
    return [nowString isEqualToString:selfString];
}

- (BOOL)isYesterday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDate *nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate *selfDate = [fmt dateFromString:[fmt stringFromDate:self]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == 1;
}
@end
